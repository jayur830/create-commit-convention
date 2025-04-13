# Commit Convention 자동 설치 툴킷

> ### *Deprecated*  
> 이 프로젝트는 [@opentoyapp/commit-convention](https://github.com/opentoyapp/commit-convention)으로 이관되었습니다.

프로젝트 세팅할 때마다 `husky`, `commitlint`, `commitizen` 등등등 맨날 수동으로 `npm i -D 어쩌구 ...` 하면서 깔았었는데 이게 너무 귀찮아서 그냥 모듈로 만들었습니다.  

## Usage

사용법은 아래와 같이 하시면 됩니다.

```bash
npx create-commit-convention   # npm
yarn create commit-convention  # yarn
pnpm create commit-convention  # pnpm
```

위 명령을 실행하시면 본인의 프로젝트에 `.cz-config.js`, `commitlint.config.js`, `.husky` 디렉토리, `.husky` 디렉토리 밑에 `commit-msg`, `prepare-commit-msg`라는 파일이 생길껍니다.  
그리고 `package.json`의 `scripts`에 `prepare`라는 스크립트가 추가되고, `config`라는 필드에 commitizen 관련 설정이 추가되어 있을껍니다.

그리고 `.git` 디렉토리가 프로젝트에 있어야 하는데 없으면 자동으로 `git init` 합니다.

