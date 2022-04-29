# image
$dockerfile = "Dockerfile"
$tag = "jan8080/toolbox"

# https://nodejs.org/en/download/releases/
$NODE_VERSION='v18.0.0'

# build
Write-Output "## image build ##"
Write-Output "dockerfile: $dockerfile"
Write-Output "tag: $tag"
Write-Output "working dir: $PWD"
Write-Output "node version: $NODE_VERSION"

docker build --pull --no-cache --progress plain     `
    --file $dockerfile                        `
    --build-arg NODE_VERSION=$NODE_VERSION          `
    --tag $tag                                      `
    .

# smoke test
Write-Output "## smoke test ##"
(
    "docker run --rm $tag",
    'pwsh -Command',
    '''Write-Output "                       `
        ==DOTNET==  $(dotnet --version)     `
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
