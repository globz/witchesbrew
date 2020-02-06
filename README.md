TODO :
- Add documentation here
- Finalize build-architecture & make use of $USER instead of TARGET
- Improve install.sh, try to replace exec bash
- Determine invocation sequence: witchesbrew $TARGET $BUILD_SCRIPT || witchesbrew (run hardcoded cauldron configuration)
- Find $SCRIPT with locate -br '^build-cronjobs.sh$' OR define $BREW_TYPE when invoking a single $BUILD_SCRIPT
