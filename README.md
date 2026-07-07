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

### Part setup order
| Offset | CC   | Use |
| ------ | ---- | --- |
| 0 | cc0 | Bank MSB |
| 1 | cc32 | Bank LSB |
| 2 | pc | Program |
| 3 | cc7 | Volume |
| 4 | cc11 | Expression |
| 5 | cc10 | Panpot |
| 6 | cc1 | Modulation |
| 7 | cc2 | Breath |
| 8 | cc4 | Foot |
| 9 | cc91 | Reverb |
| 10 | cc92 | Chorus |
| 11 | cc94 | Variation |
| 12 | cc74 | Brightness (`0x0120`) |
| 13 | cc71 | Resonance (`0x0121`) |
| 14 | cc73 | Attack (`0x0163`) |
| 15 | cc75 | Decay (`0x0164`) |
| 16 | cc72 | Release (`0x0166`) |
| 17 | cc76 | Vibrato Rate (`0x0108`) |
| 18 | cc77 | Vibrato Depth (`0x0109`) |
| 19 | cc78 | Vibrato Delay (`0x010a`) |
| 20 | NRPN | `0x7f7f` |
| 21 | RPN | `0x0000` Pitch Range |
| 22 | RPN | `0x0001` Coarse Tune |
| 23 | RPN | `0x0002` Fine Tune |
| 24 | RPN | `0x7f7f` |
| 25 | cc64 | Sustain |
| 26 | cc65 | Portamento Switch |
| 27 | cc5 | Portamento Time |

## Metadata schema
### TSV notation
#### Available fields
- `id`: Short unique numeric ID.
- `text`: Short text for programmatic UI display texts.
- `file`: The filename without extensions.
- `artist`: The name of the artist.
- `title`: Name of the audio clip.
- `year`: Release year of the audio clip.
- `standard`: The standard of the file. Follows the standards notation.
- `audio`: The original target synth, or the synth used to render the audio if explained in `extra`.
- `renderer`: The person who rendered the audio.
- `extra`: Additional comments.

### Natural notation
```
Artist - Title (Year) [Standards]
00/99 Example Album
1999 © Example Copyright Holder LLC

Audio rendered {by @user@platform.com} with Example Synth.
Video rendered with {Example Visualiser}.
```

### Standards notation
#### Symbols
- `,`: Supplementary setup. Highest interpretation priority. Conforms to the `[base, supplementary 1, ...]` syntax. (e.g. `[XG, PLG-VL]`)
- `+`: Parallel setup. Medium interpretation priority. (e.g. `[S90 ES + KROSS 2]`)
- `;`: Transformative setup. Lowest interpretation priority. (e.g. `[QY10; XG]`)

#### Common keywords
##### Non-GM
- `DOC`: Yamaha Disk Orchestra Collection.
- `MT-32`: Roland MT-32.
- `QY10`: Yamaha QY10.

##### GM1
- `GM`: General MIDI 1.
- `05R/W`: Korg 05R/W or X5.
- `CS`: Yamaha CS1x or CS2x.
- `GMega`: Kawai GMega.
- `GS`: Roland GS.
- `GUS`: Gravis UltraSound.
- `Motif ES`: Yamaha Motif ES.
- `MU100+`: Yamaha MU100 and onwards.
- `NS5R`: Korg NS5R or NX5R.
- `PLG-AN`: Yamaha virtual analog synthesis plugin.
- `PLG-AP`: Yamaha acoustic piano plugin.
- `PLG-DR`: Yamaha drums plugin.
- `PLG-DX`: Yamaha FM/PM synthesis plugin (DX7).
- `PLG-PC`: Yamaha percussion plugin.
- `PLG-PF`: Yamaha piano plugin.
- `PLG-SG`: Yamaha singing/formant synthesis plugin.
- `PLG-VL`: Yamaha virtual acoustic/digital waveguide/feedback synthesis plugin.
- `PSR`: Yamaha PSR/DGX... panel voice.
- `S90 ES`: Yamaha S90 ES.
- `SG`: Akai SG.
- `X5D`: Korg X5D or X5DR.
- `XG`: Yamaha XG.

##### GM2
- `GM2`: General MIDI 2.
- `KROSS 2`: Korg KROSS 2.
- `PA`: Korg PA.
- `SD`: Roland SD.