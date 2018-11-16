RUNONCE=true

patch_mixer_toplevel() {
  case $1 in
    -c) if [ "$(grep "<ctl name=\"$2\" value=\".*\" />" $MODPATH/system/vendor/etc/mixer_paths_tavil.xml)" ]; then
          local num=$(sed -n "/<ctl name=\"$2\" value=\".*\" \/>/=" $MODPATH/system/vendor/etc/mixer_paths_tavil.xml | head -n1)
          sed -i "$num s/\(<ctl name=\"$2\" value=\"\).*\(\" \/>\)/\1$3\2/" $MODPATH/system/vendor/etc/mixer_paths_tavil.xml
        fi;;
    -p) if [ "$(sed -n "/ *<path name=\"$2\">/,/ *<\/path>/ {/<ctl name=\"$3\" value=\".*\" \/>/p}" $MODPATH/system/vendor/etc/mixer_paths_tavil.xml)" ]; then
          sed -i "/ *<path name=\"$2\">/,/ *<\/path>/ s/\(<ctl name=\"$3\" value=\".*\" \/>\)/\1\n        <ctl name=\"$4\" value=\"$5\" \/>/" $MODPATH/system/vendor/etc/mixer_paths_tavil.xml
        fi;;
  esac
}

patch_mixer_toplevel -c "EAR PA Gain" "G_8_DB"
patch_mixer_toplevel -c "RX0 Digital Volume" "90"
patch_mixer_toplevel -c "RX7 Digital Volume" "88"
patch_mixer_toplevel -c "SLIM RX0 MUX" "AIF1_PB"
patch_mixer_toplevel -c "RX INT0_1 MIX1 INP0" "RX0"
patch_mixer_toplevel -c "RX HPH Mode" "CLS_H_HIFI"
patch_mixer_toplevel -p "deep-buffer-playback quat_i2s" "QUAT_MI2S_RX Audio Mixer MultiMedia1" "SLIMBUS_0_RX Audio Mixer MultiMedia1" "1"
patch_mixer_toplevel -p "low-latency-playback quat_i2s" "QUAT_MI2S_RX Audio Mixer MultiMedia5" "SLIMBUS_0_RX Audio Mixer MultiMedia5" "1"
patch_mixer_toplevel -p "compress-offload-playback quat_i2s" "QUAT_MI2S_RX Audio Mixer MultiMedia4" "SLIMBUS_0_RX Audio Mixer MultiMedia4" "1"
sed -i "/ *<path name=\"speaker\">/a\      <ctl name=\"SLIMBUS_0_RX Audio Mixer MultiMedia1\" value=\"1\" \/>\n\
      <ctl name=\"QUAT_MI2S_RX Channels\" value=\"One\" \/>\n\
      <ctl name=\"SLIM RX0 MUX\" value=\"AIF1_PB\" \/>\n\
      <ctl name=\"CDC_IF RX0 MUX\" value=\"SLIM RX0\" \/>\n\
      <ctl name=\"SLIM_0_RX Channels\" value=\"One\" \/>\n\
      <ctl name=\"RX INT0_1 MIX1 INP0\" value=\"RX0\" \/>\n\
      <ctl name=\"RX INT0 DEM MUX\" value=\"CLSH_DSM_OUT\" \/>\n\
      <ctl name=\"EAR SPKR PA Gain\" value=\"G_6_DB\" \/>\n\
      <ctl name=\"RX0 HPF cut off\" value=\"MIN_3DB_150Hz\" \/>\n\
      <ctl name=\"RX0 Digital Volume\" value=\"90\" \/>\n\
      <ctl name=\"RX7 Digital Volume\" value=\"88\" \/>\n\
      <ctl name=\"SLIM_0_RX SampleRate\" value=\"KHZ_96\" \/>" $MODPATH/system/vendor/etc/mixer_paths_tavil.xml
sed -i "/ *<path name=\"speaker-mono\">/a\      <ctl name=\"SLIMBUS_0_RX Audio Mixer MultiMedia1\" value=\"1\" \/>\n\
      <ctl name=\"QUAT_MI2S_RX Channels\" value=\"One\" \/>\n\
      <ctl name=\"SLIM RX0 MUX\" value=\"AIF1_PB\" \/>\n\
      <ctl name=\"CDC_IF RX0 MUX\" value=\"SLIM RX0\" \/>\n\
      <ctl name=\"SLIM_0_RX Channels\" value=\"One\" \/>\n\
      <ctl name=\"RX INT0_1 MIX1 INP0\" value=\"RX0\" \/>\n\
      <ctl name=\"RX INT0 DEM MUX\" value=\"CLSH_DSM_OUT\" \/>\n\
      <ctl name=\"EAR SPKR PA Gain\" value=\"G_6_DB\" \/>\n\
      <ctl name=\"RX0 HPF cut off\" value=\"MIN_3DB_150Hz\" \/>\n\
      <ctl name=\"RX0 Digital Volume\" value=\"90\" \/>\n\
      <ctl name=\"RX7 Digital Volume\" value=\"88\" \/>\n\
      <ctl name=\"SLIM_0_RX SampleRate\" value=\"KHZ_96\" \/>" $MODPATH/system/vendor/etc/mixer_paths_tavil.xml
