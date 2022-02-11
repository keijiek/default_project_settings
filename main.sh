# #!/bin/sh

git_setting () {
  echo 'node_modules/' > .gitignore
  git init
  git add .
  git commit -m 'first commit'
  git branch -M main
}

nodeSetup () {
  echo "lts/gallium" > .nvmrc
  # source ~/.nvm/nvm.sh
  # nvm install
}

makePackageJson () {
  npm init -y
}

makeCodeWorkspace () {
  projectname=basename `pwd`
  echo '{
  "folders": [
		{
			"path": "."
		}
	],
	"settings": {
		"editor.tabSize": 2
	}
}' > "$projectname/$projectname.code-workspace"
}

nodeSetup
makePackageJson
makeCodeWorkspace
