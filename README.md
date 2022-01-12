# tgbugs-overlay
A portage overlay with ebuilds for various programs. Occasionally used to hold version bumps prior to an official ebuild release.

If you are using the dev-python ebuilds in this repo save yourself a headache and add `dev-python/*::tgbugs-overlay` to `package.accept_keywords` so that portage won't act like keyworded ebuilds don't exist and produce completely bogus use flag and keywording suggestions.
