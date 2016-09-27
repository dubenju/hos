REM Start qemu on windows.
@ECHO OFF

REM SDL_VIDEODRIVER=directx is faster than windib. But keyboard cannot work well.
SET SDL_VIDEODRIVER=windib

REM SDL_AUDIODRIVER=waveout or dsound can be used. Only if QEMU_AUDIO_DRV=sdl.
REM SET SDL_AUDIODRIVER=dsound
SET SDL_AUDIODRIVER=none

REM QEMU_AUDIO_DRV=dsound or fmod or sdl or none can be used. See qemu -audio-help.
SET QEMU_AUDIO_DRV=dsound

REM QEMU_AUDIO_LOG_TO_MONITOR=1 displays log messages in QEMU monitor.
SET QEMU_AUDIO_LOG_TO_MONITOR=0

REM PCI-based PC(default): -M pc 
REM ISA-based PC         : -M isapc
REM -M isapc is added for NE2000 ISA card.

REM qemu.exe -L . -m 128 -hda linux.img -soundhw all -localtime -M isapc
REM qemu.exe -L . -m 128 -fda fdimage0.bin -soundhw all -localtime -M isapc
REM qemu.exe -L . -m 32 -localtime -std-vga -fda everyos.bin
qemu.exe -L . -m 32 -localtime -std-vga -fda M32-085.IMG