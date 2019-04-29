# Used by "mix format"
[
  inputs: ["mix.exs", "apps/*/mix.exs", "apps/*/{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: [
    field: :*,
    interface: :*,
    value: :*,
    object: :*,
    arg: :*,
    resolve: :*,
    resolve_type: :*,
    plug: :*,
    pipe_through: :*,
    get: :*,
    post: :*,
    forward: :*
  ]
]
