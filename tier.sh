#!/bin/sh
set -e

function logf() {
    echo "tier.sh: $@" 1>&2
}

# TIER_RUN_DYNOS, if set, is a comma seperated list of process types the tier
# sidecar should run for.
#
# If not set, the sidecar will run for all process types.
skip=0
if [ -n "$TIER_RUN_DYNOS" ]; then
	dyno_type=$(echo $DYNO | cut -d. -f1)
	if ! echo $TIER_RUN_DYNOS | grep -q $dyno_type; then
		logf "Not running on $dyno_type dyno, skipping"
		return
	fi
fi

stripekey=$STRIPE_API_KEY
if [ -z "$stripekey" ]; then
	logf "error: STRIPE_API_KEY not set, not serving"
	return
fi

addr=$TIER_ADDR
if [ -z "$addr" ]; then
	addr="127.0.0.1:8080"
fi

# Set live to "--live" if the STRIPE_API_KEY is a live key.
live=""
if echo $stripekey | grep -q "^sk_live_"; then
	live="--live"
fi

if [ $skip -eq 0 ]; then
	/app/bin/tier/tier $live serve -addr $addr &
fi
