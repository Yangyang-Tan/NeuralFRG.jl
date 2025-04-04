"""
    PINN(chain, rng::AbstractRNG=Random.default_rng())
    PINN(rng::AbstractRNG=Random.default_rng(); kwargs...)

A container for a neural network, its states and its initial parameters.
The default element type of the parameters is `Float64`.

## Fields

  - `phi`: [`ChainState`](@ref) if there is only one neural network, or an named tuple of [`ChainState`](@ref)s if there are multiple neural networks.
    The names are the same as the dependent variables in the PDE.
  - `init_params`: The initial parameters of the neural network.

## Arguments

  - `chain`: `AbstractLuxLayer` or a named tuple of `AbstractLuxLayer`s.
  - `rng`: `AbstractRNG` to use for initialising the neural network. If yout want to set the seed, write

```julia
using Random
rng = Random.default_rng()
Random.seed!(rng, 0)d
```

and pass `rng` to `PINN` as

```julia
using Sophon

chain = FullyConnected((1, 6, 6, 1), sin);

# sinple dependent varibale
pinn = PINN(chain, rng);

# multiple dependent varibales
pinn = PINN(rng; a=chain, b=chain);
```
"""
struct PINN{PHI, P}
    phi::PHI
    init_params::P
end

function PINN(rng::AbstractRNG=Random.default_rng(); kwargs...)
    return PINN((; kwargs...), rng)
end

function PINN(chain::NamedTuple, rng::AbstractRNG=Random.default_rng())
    phi = map(m -> ChainState(m, rng), chain)
    init_params = initialparameters(rng, phi)

    return PINN{typeof(phi), typeof(init_params)}(phi, init_params)
end

function PINN(chain::AbstractLuxLayer, rng::AbstractRNG=Random.default_rng())
    phi = ChainState(chain, rng)
    init_params = initialparameters(rng, phi)
    return PINN{typeof(phi), typeof(init_params)}(phi, init_params)
end

function initialparameters(rng::AbstractRNG, pinn::PINN)
    return initialparameters(rng, pinn.phi)
end