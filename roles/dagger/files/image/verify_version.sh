#!/bin/sh

[ -z "${DAGGER_VERSION}" ] && echo "DAGGER_VERSION env is not set" && exit 1
case $(dagger version) in
"dagger $DAGGER_VERSION "*) exit 0 ;;
*)
    echo "FAIL: dagger version is not $DAGGER_VERSION"
    echo "expected: dagger $DAGGER_VERSION"
    echo "actual: $(dagger version)"
    exit 2
    ;;
esac
