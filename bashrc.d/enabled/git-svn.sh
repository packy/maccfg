#! bash

is_git_svn_dir () {
    is_git_dir && git cat-file commit HEAD | grep -q git-svn-id
}
