# image
$tag = "jan8080/toolbox:dotnet"

# build
Write-Output "## image build ##"
Write-Output "tag: $tag"
Write-Output "working dir: $PWD"

docker build --pull --no-cache --progress plain     `
    --file Dockerfile-dotnet                        `
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
        ==PWSH==    $(pwsh --version)       `
        ==PYTHON==  $(python --version)     `
    "'''
)
| Join-String -Separator " "
| Invoke-Expression -PipelineVariable _
