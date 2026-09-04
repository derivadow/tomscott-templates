# Versioning a Blot site privately and publishing its templates

This guide describes how the files for [tomscott.name](https://tomscott.name) are maintained. The arrangement provides version history and a private backup for the complete Blot site while publishing only its reusable template layer.

It is an example rather than a feature built into Blot. Adapt repository names, paths and licensing rules to suit your own site.

## Architecture

The folder synchronised by Blot is the canonical working copy:

```text
iCloud Drive / Blot
        │
        ├── Blot sync ────────────→ live website
        │
        └── Git push ─────────────→ private monorepo
                                         │
                                         └── GitHub Action
                                                  │
                                                  ▼
                                      public template repository
```

The private repository contains the complete site. The public repository is generated from selected directories and is not edited independently.

For this site, the publication boundary is:

| Private source | Public destination | Purpose |
| --- | --- | --- |
| `Templates/index/` | repository root | Blot templates, CSS, JavaScript and configuration |
| `images/site/` | `images/site/` | Favicons, icons and site furniture |

Posts, pages, drafts, fonts, photographs, presentations and all other files remain private.

## 1. Make the Blot folder a private repository

First use Blot's **Move to folder** option so that the template is present inside the folder synchronised with the site. Blot has [separate instructions for local template editing](https://blot.im/questions/3299).

Initialise Git at the root of the complete Blot folder, not inside the individual template directory:

```sh
cd "/path/to/Blot"
git init
git add .
git commit -m "Initial site backup"
git branch -M main
git remote add origin https://github.com/USERNAME/PRIVATE-REPOSITORY.git
git push -u origin main
```

Create the GitHub repository as **private** before pushing. Review the staged files carefully: the Blot folder may contain drafts, licensed fonts, photographs or other material that must not be published.

Cloud storage and Git both track filesystem changes. Avoid running Git operations on the same synchronised folder from several computers at once, and ensure files are fully downloaded before committing. Finder and editor metadata can usually be excluded:

```gitignore
.DS_Store
**/.DS_Store
.nova/
```

## 2. Create the public repository

Create a separate public repository for the material that can be shared. Add its own README and licence. These files belong to the public project and should be preserved whenever templates are republished.

The private repository remains the only source of truth for template code. Treat the public repository as a release destination; editing both copies independently creates drift and makes the next mirror operation ambiguous.

## 3. Add the publication workflow

Save the following as `.github/workflows/publish-templates.yml` in the private repository. Replace the public repository name and source paths where necessary.

```yaml
name: Publish templates

on:
  push:
    branches:
      - main
    paths:
      - "Templates/index/**"
      - "images/site/**"
      - ".github/workflows/publish-templates.yml"
  workflow_dispatch:

permissions:
  contents: read

concurrency:
  group: publish-templates
  cancel-in-progress: false

jobs:
  publish:
    runs-on: ubuntu-latest

    steps:
      - name: Check out the private source repository
        uses: actions/checkout@v6
        with:
          ref: main

      - name: Check out the public template repository
        uses: actions/checkout@v6
        with:
          repository: USERNAME/PUBLIC-REPOSITORY
          ref: main
          token: ${{ secrets.TEMPLATES_REPO_TOKEN }}
          path: public-templates

      - name: Mirror the template directory
        run: |
          rsync --archive --delete \
            --exclude='.git/' \
            --exclude='LICENSE' \
            --exclude='README.md' \
            --exclude='docs/' \
            --exclude='images/' \
            Templates/index/ public-templates/

          mkdir -p public-templates/images/site
          rsync --archive --delete images/site/ public-templates/images/site/

      - name: Commit and publish changes
        working-directory: public-templates
        run: |
          git add --all

          if git diff --cached --quiet; then
            echo "Public templates are already up to date."
            exit 0
          fi

          git config user.name "github-actions[bot]"
          git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
          git commit -m "Publish templates from private source"
          git push origin HEAD:main
```

The standard `GITHUB_TOKEN` cannot write to a different repository, so the second checkout uses a separate, narrowly scoped token.

The first `rsync` makes the public root match the canonical template directory. Its exclusions preserve files that belong only to the public repository. The entire `images/` directory is excluded from that operation; a second command mirrors only `images/site/`. Do not use `--delete-excluded`, which would remove the preserved files.

## 4. Create the publication token

Create a [fine-grained personal access token](https://github.com/settings/personal-access-tokens/new) with:

- the account that owns the repositories as its resource owner;
- access to **only** the public template repository; and
- the repository permission **Contents: Read and write**.

GitHub displays the token once. In the private repository, open **Settings → Secrets and variables → Actions**, create a repository secret named `TEMPLATES_REPO_TOKEN`, and paste the token there. Never commit the token or put it in the workflow file.

Choose an expiry appropriate for the site and record when the token needs rotating. When it expires, the private backup and Blot publication will continue, but the public-template workflow will fail until the secret is replaced.

## 5. Test the publication

Open **Actions → Publish templates** in the private repository and run the workflow manually. A successful run should create a commit by `github-actions[bot]` in the public repository.

Check the actual public files as well as the green workflow result. A useful first test is a harmless change to `Templates/index/package.json`, followed by confirmation that:

1. Blot reflects the change on the site;
2. the private repository contains the source commit;
3. the Action completes successfully; and
4. the corresponding public file contains the same change.

After that, pushes to `main` which affect `Templates/index/`, `images/site/`, or the workflow itself will publish automatically. Other site changes are backed up privately but do not trigger public publication.

## Maintenance and recovery

The Action is intentionally one way. Do not make canonical changes in the public repository: a later run may overwrite or delete them. Public-only files must be listed among the `rsync` exclusions.

If the workflow reports `Input required and not supplied: token`, the Actions secret is missing or misnamed. If checkout or push returns a permission error, confirm that the token has not expired, still has access to the selected public repository, and has contents read-and-write permission.

Keep licensing boundaries explicit. The fact that a private monorepo contains several kinds of material does not give them a common licence. Publish only directories whose contents have been reviewed for public distribution.
