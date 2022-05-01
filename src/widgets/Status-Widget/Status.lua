############
# Settings #
############
#Discord: Mhykol#0407

background yes
use_xft yes
xftfont Liberation Sans:size=9
xftalpha 1
update_interval 1.0
total_run_times 0
own_window yes
own_window_type dock
own_window_transparent yes
own_window_hints undecorated,below,sticky,skip_taskbar,skip_pager
own_window_argb_visual yes
double_buffer yes
minimum_size 200 200
maximum_width 240
draw_shades no
draw_outline no
draw_borders no
draw_graph_borders no
default_color 656667
default_shade_color 000000
default_outline_color 828282
default_bar_size 240 2
alignment top_right
gap_x 15
gap_y 30
no_buffers yes
uppercase no
cpu_avg_samples 2
override_utf8_locale no
own_window_argb_value 0
own_window_colour 000000
TEXT



























${font Oswald:bold:size=10}${color1}GNU/Linux ${color2} ${hr 2}

${color1}${goto 15}OS     : ${color3}${execi 86400 cat `ls -atr /etc/*-release | tail -2` | grep "PRETTY_NAME" | cut -d= -f2 |  sed 's/"//g'}
${color1}${goto 15}Kernel : ${color3}$kernel

${color1}${font Oswald:size=16}${font} ${voffset -10} Processes > $hr${color}

${color1}${goto 100}CPU usage
${color1}${goto 35}${stippled_hr}${color2}
${goto 35}${top name 1} ${color2}${top cpu 1}%
${goto 35}${top name 2} ${color2}${top cpu 2}%
${goto 35}${top name 3} ${color2}${top cpu 3}%
${goto 35}${top name 4} ${color2}${top cpu 4}%
${goto 35}${top name 5} ${color2}${top cpu 5}%

${color1}${goto 35}Processes: ${color2}$processes ${color1}Running: ${color2}$running_processes

${color1}${font Oswald:size=16}${font} ${voffset -10} System > $hr${color}

${color1}${goto 35}Core 1 : ${color2}${freq_g 1}GHz ${alignr}${cpu cpu0}% ${cpubar cpu0 4,100}
${color1}${goto 35}Core 2 : ${color2}${freq_g 2}GHz ${alignr}${cpu cpu1}% ${cpubar cpu1 4,100}
${color1}${goto 35}Core 3 : ${color2}${freq_g 3}GHz ${alignr}${cpu cpu2}% ${cpubar cpu2 4,100}
${color1}${goto 35}Core 4 : ${color2}${freq_g 4}GHz ${alignr}${cpu cpu3}% ${cpubar cpu3 4,100}
