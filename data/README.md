This directory will hold various data files.

Countdown files come in pairs: `foo.ts` and `foo.txt`.
The `.ts` file contains the expiration timestamp of a
countdown, and the `.txt` file contains a rendition
of the countdown (e.g. `00:01:59` or `--:--:--` for
expired countdowns).

Elgato light files are YAML files containing parameters
for Elgato Key lights. These files are used by the
`elgatoctl` script to change lights.

