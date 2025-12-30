# MIDI Covers
🎼 My archive of MIDI music projects.

## Formatting guidelines
### File types
Listed by order of preference.

- XWS: XGworks Sequence
- Common SMF type 1: Multi-track, single channel per track.
- MU SEQ SMF type 1: Multi-track, all channels of a single port per track.
- XF: Single track for single port, additional XF tracks for XF metadata.
- SMF type 0: Single track for single port.

### Meta events
- Song title: **Required**. Also known as "sequence name".
- Copyright: **Preferred**. Preferrably in this format: `1999 © Yamaha Musicsoft Europe`
- Text event: **Preferred**. List relevant information (e.g. original composer, data programmer) in natural language.
- Instrument: **Preferred**. List compatible target synth modules.

### Setup time partitioning
All setups done preferrably at 120 BPM, 4/4. Setup levels include basic (1s), part (2s) and full (4s). This is only a recommendation for GM, GM2, XG, GS (SC) and SD.

| Bar length | Level | Designation |
| ---------- | ----- | ----------- |
| 01/01      | Basic | System resets |
| 01/03      | Full  | Global SysEx params |
| 01/01      | Basic | Part voice + CC + RPN |
| 01/01      | Part  | Part SysEx |
| 01/02      | Part  | Part NRPN |

- Short SysEx messages (e.g. non-dump GM, XG and GS SysEx) needs at least 5 ticks for proper transmission. It's recommended to have 8 or 10 ticks per SysEx string.
- System resets and global SysEx are recommended to occupy a dedicated track per-device. Letter displays, bitmap displays and channel displays (hardcoded performance) are also recommended to occupy a dedicated track per-device.
- It's recommended to leave around 100ms (96 ticks) for each reset, or 50ms (48 ticks) for Yamaha and Roland. Kawai GMega requires 2.5s for both GMega bank select and effect select.
- Part voice + CC + RPN setups are recommended to occupy 30 ticks per-part per-port, each event adding 1 tick, all in a descending order.
- Part NRPN are recommended to occupy 30 ticks per-part per-port, each NRPN commit (a cc99, cc98 and cc6 triplet) occupy a tick, all in a descending order.