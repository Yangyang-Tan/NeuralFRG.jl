using NeuralFRG
using Documenter

DocMeta.setdocmeta!(NeuralFRG, :DocTestSetup, :(using NeuralFRG); recursive=true)

makedocs(;
    modules=[NeuralFRG],
    authors="Yang-yang Tan",
    sitename="NeuralFRG.jl",
    format=Documenter.HTML(;
        canonical="https://Yangyang-Tan.github.io/NeuralFRG.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Yangyang-Tan/NeuralFRG.jl",
    devbranch="main",
)
