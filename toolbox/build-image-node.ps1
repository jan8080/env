# image
$tag = "jan8080/toolbox:node"

# https://github.com/PowerShell/PowerShell/releases
$PWSH_VERSION='7.2.3'
# https://nodejs.org/en/download/releases/
$NODE_VERSION='v18.0.0'

# build
Write-Output "## image build ##"
Write-Output "tag: $tag"
Write-Output "working dir: $PWD"
Write-Output "pwsh version: $PWSH_VERSION"
Write-Output "node version: $NODE_VERSION"

docker build --pull --no-cache --progress plain     `
    --file Dockerfile-node                          `
    --build-arg PWSH_VERSION=$PWSH_VERSION          `
    --build-arg NODE_VERSION=$NODE_VERSION          `
    --tag $tag                                      `
    .

# smoke test
Write-Output "## smoke test ##"
(
    "docker run --rm $tag",
    'pwsh -Command',
    '''Write-Output "                       `
        ==GIT==     $(git --version)        `
        ==GITHUB==  $(gh --version)         `
        ==NODE==                            `
        --node      $(node --version)       `
        --npm       $(npm --version)        `
        --npx       $(npx --version)        `
        --corepack  $(corepack --version)   `
        ==PWSH==    $(pwsh --version)       `
        ==PYTHON==  $(python --version)     `
    "'''
)
| Join-String -Separator " "
| Invoke-Expression -PipelineVariable _
