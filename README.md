# The Official Tier.run Buildpack

This [buildback](https://devcenter.heroku.com/articles/buildpacks) installs and
runs the [Tier sidecar](https://tier.run/docs/cli/serve) in [Heroku](https://heroku.com)
dynos.

# Install

	$ heroku buildpack:add https://github.com/tierrun/tier-run-buildpack

# Environment

The below environment variables can be set using `heroku config:set X=Y` or via
the Heroku dashboard.

* `STRIPE_API_KEY`: The required Stripe key (live or test) to use
* `TIER_VERSION`: The optional Tier sidecar version (default is v0.6.2)
* `TIER_ADDR`: The optional address the sidecar will listen on (default is '127.0.0.1:8080')
* `TIER_RUN_DYNOS`: An optional comma seperated list of dyno type names (e.g. "web") to run the sidecar in. If unset, all dynos types will run the sidecar.
