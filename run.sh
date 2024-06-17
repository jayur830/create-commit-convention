if [ ! -d '.git' ]; then
  git init
fi
if [ -d package-lock.json ]; then
  npm i -D \
    husky \
    @commitlint/cli \
    @commitlint/config-conventional \
    commitizen \
    cz-customizable
  npx husky
elif [ -d yarn.lock ]; then
  yarn add -D \
    husky \
    @commitlint/cli \
    @commitlint/config-conventional \
    commitizen \
    cz-customizable
  yarn husky
elif [ -d pnpm-lock.yaml ]; then
  pnpm add -D \
    husky \
    @commitlint/cli \
    @commitlint/config-conventional \
    commitizen \
    cz-customizable
  pnpm dlx husky
fi

echo "module.exports = {
  extends: ['@commitlint/config-conventional'],
};" > commitlint.config.js

echo "module.exports = {
  types: [
    {
      value: 'feat',
      name: 'feat:\t\t신규 기능 개발로 인한 코드 변경 사항',
    },
    {
      value: 'fix',
      name: 'fix:\t\t버그 개선으로 인한 코드 변경 사항',
    },
    {
      value: 'docs',
      name: 'docs:\t\tmd 파일 및 기타 문서 변경 사항',
    },
    {
      value: 'style',
      name: 'style:\t코드 포맷팅, 세미콜론 누락 등 코드 정리에 의한 변경 사항',
    },
    { value: 'refactor', name: 'refactor:\t코드 리팩토링 변경 사항' },
    {
      value: 'test',
      name: 'test:\t\t테스트 코드 작성 및 수정에 대한 변경 사항',
    },
    {
      value: 'chore',
      name: 'chore:\t패키지 관련 설정 변경 사항',
    },
    {
      value: 'perf',
      name: 'perf:\t\t성능 개선으로 인한 코드 변경 사항',
    },
    {
      value: 'revert',
      name: 'revert:\t롤백에 의한 변경 사항',
    },
    {
      value: 'build',
      name: 'build:\t번들러 설정 또는 라이브러리 버전 등 빌드에 영향이 있는 변경 사항',
    },
    {
      value: 'ci',
      name: 'ci:\t\t배포 관련 구성파일 변경 사항',
    },
  ],
  scopes: [''],
  allowCustomScopes: true,
  subjectLimit: 255,
  allowBreakingChanges: ['feat', 'fix', 'refactor', 'chore', 'perf', 'revert', 'build'],
  skipQuestions: ['body'],
};" > .cz-config.js

if [ -d '.husky' ]; then
  if [ -d package-lock.json ]; then
    echo '#!/usr/bin/env sh\n. "$(dirname -- "$0")/_/husky.sh"\n\nnpx commitlint --edit $1' > .husky/commit-msg
    echo '#!/usr/bin/env sh\n. "$(dirname -- "$0")/_/husky.sh"\n\nexec < /dev/tty && npx cz --hook || true' > .husky/prepare-commit-msg
  elif [ -d yarn.lock ]; then
    echo '#!/usr/bin/env sh\n. "$(dirname -- "$0")/_/husky.sh"\n\nyarn commitlint --edit $1' > .husky/commit-msg
    echo '#!/usr/bin/env sh\n. "$(dirname -- "$0")/_/husky.sh"\n\nexec < /dev/tty && yarn cz --hook || true' > .husky/prepare-commit-msg
  elif [ -d pnpm-lock.yaml ]; then
    echo '#!/usr/bin/env sh\n. "$(dirname -- "$0")/_/husky.sh"\n\npnpm commitlint --edit $1' > .husky/commit-msg
    echo '#!/usr/bin/env sh\n. "$(dirname -- "$0")/_/husky.sh"\n\nexec < /dev/tty && pnpm cz --hook || true' > .husky/prepare-commit-msg
  fi
fi

if [ `grep -c '"prepare": "husky"' package.json` == 0 ]; then
  sed -i '' 's/  "scripts": {/  "scripts": {\n    "prepare": "husky",/g' package.json
fi
if [ `grep -c '"path": "node_modules/cz-customizable"' package.json` == 0 ]; then
  sed -i '' 's/  }$/  },\n  "config": {\n    "commitizen": {\n      "path": "node_modules\/cz-customizable"\n    }\n  }/g' package.json
fi
