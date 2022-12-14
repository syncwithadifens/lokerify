# Delete all workflows

```
user=gh_username repo=repo_name; gh api repos/$user/$repo/actions/runs \
--paginate -q '.workflow_runs[] | select(.head_branch != "master") | "\(.id)"' | \
xargs -n1 -I % gh api --silent repos/$user/$repo/actions/runs/% -X DELETE
xargs: warning: options --max-args and --replace/-I/-i are mutually exclusive, ignoring previous --max-args value
❯ user=withadifens repo=instagram_clone; gh api repos/$user/$repo/actions/runs \
--paginate -q '.workflow_runs[] | select(.head_branch != "master") | "\(.id)"' | \
xargs -n1 -I % gh api --silent repos/$user/$repo/actions/runs/% -X DELETE
xargs: warning: options --max-args and --replace/-I/-i are mutually exclusive, ignoring previous --max-args value
```

# Delete remote github tag

```
git tag -l | xargs -n 1 git push --delete origin
```

(need gh token)

# Delete local git tag

```
git fetch
git tag -d $(git tag -l)
```
