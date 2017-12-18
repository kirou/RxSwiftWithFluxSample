#!/bin/sh
if which swiftlint >/dev/null; then
    swiftlint version
else
    echo "SwiftLint does not exist, download from https://github.com/realm/SwiftLint"
    exit
fi

parse_yaml() {
    local prefix=$2
    local s
    local w
    local fs
    s='[[:space:]]*'
    w='[a-zA-Z0-9_]*'
    fs="$(echo @|tr @ '\034')"
    sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s[:-]$s\(.*\)$s\$|\1$fs\2$fs\3|p" "$1" |
    awk -F"$fs" '{
    indent = length($1)/2;
    vname[indent] = $2;
    for (i in vname) {if (i > indent) {delete vname[i]}}
        if (length($3) > 0) {
            vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
            printf("%s%s%s=(\"%s\")\n", "'"$prefix"'",vn, $2, $3);
        }
    }' | sed 's/_=/+=/g'
}

# Excluded pathes from .swiftlint.yml
EXCLUDEDS=`parse_yaml ./.swiftlint.yml | grep excluded | sed -e "s/^.*(\(".*"\)).*$/\1/" | tr -d "\""`

if git rev-parse --verify HEAD >/dev/null 2>&1
then
    against=HEAD
fi
# Redirect output to stderr.
exec 1>&2

IFS=$'\n'
# Target the swift files that has been changed.
for FILE in `git diff-index --name-status $against -- | grep -E '^[AUM].*\.swift$'| cut -c3-`; do
  # Skip if excluded
  EXCLUDE_FLAG=0
  for EXCLUDED in $EXCLUDEDS; do
    if [[ $FILE =~ ^$EXCLUDED.* ]]; then
      EXCLUDE_FLAG=1
      break
    fi
  done
  if [[ $EXCLUDE_FLAG == 0 ]]; then
    # Lint
    swiftlint lint --path "$FILE"
  fi
done
