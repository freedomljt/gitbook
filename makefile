_GIT_LAST_COMMIT_TIME=$(shell TZ=UTC git log --pretty=format:'%cd' -1 --date=format-local:'%Y%m%d-%H%M%S')
_GIT_LAST_COMMIT_HASH=$(shell git rev-parse --short HEAD)
_GIT_TAG=$(_GIT_LAST_COMMIT_TIME).$(_GIT_LAST_COMMIT_HASH)

publish:
	cp -r _book/* . && git add . && git commit -m "publish $(_GIT_TAG)"
i:
	gitbook install

b:
	gitbook build

s:
	gitbook build && gitbook serve

gh:
	gitbook build && gh-pages -d _book