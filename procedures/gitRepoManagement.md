# Git Repo Management

- Development team 1 of 1 (Theo Gerontakos) works on MacBook Pro as user "theodore"
- Commit on that MacBook Pro (when ready to commit)
    - git status -s
    - git add -A
        - This adds ALL files in the queue
    - git commit -a -m "message"
        - Note that this commits all; to commit a single file, use `git commit **filename** -m "message"`
- $git push -u origin --all
    - origin https://github.com/UniverityOfWashingtonLibrariesSchemas/schemasProject.git (fetch)
    - origin https://github.com/UniverityOfWashingtonLibrariesSchemas/schemasProject.git (push)
- Or push a single file or a subset of all:
    - git push origin master
- Pull to faculty.washington.edu
    - best practice for this not yet decided by project staff
    - $git pull origin master --> this works OK, but does not guarantee repos are synced. Will pull ALL or single file.
    - $git fetch --> some flavor of fetch should work
    - $git reset --hard origin/master --> may be required in some cases for sync.
- Pull to UW Libraries windows machine
    - try: git pull origin master; if that fails, move on to the next list item
    - If the pull does not work, reset:
        - $git reset --hard (now should be ready for git pull origin master)
    - After the reset: git pull origin master
- Merge branch, pull to other repos
    - In Gitbub, see pull request
    - Merge and squash
    - Macbook: git pull origin master
    - (All unadded changes already in Macbook repo will be untouched)


###### tags: `docs_schemasProject`