############
# Settings #
############
#Discord: Mhykol#0407

background no
update_interval 1
override_utf8_locale yes
double_buffer yes
no_buffers yes
text_buffer_size 2048
own_window yes
own_window_type dock
own_window_argb_visual yes
own_window_argb_value 0
own_window_transparent yes
own_window_hints undecorated,below,sticky,skip_taskbar,skip_pager
border_inner_margin 0
border_outer_margin 0
alignment top_left
gap_x 50
gap_y 470
draw_shades no
draw_outline no
draw_borders no
draw_graph_borders no
use_xft yes
xftalpha 0
text_buffer_size 2048
uppercase no
default_color FFFFFF
own_window_colour 000000
minimum_size 0 0
TEXT


${font Oswald:bold:size=8}${color1}NOW PLAYING ${color2}${hr 2}

	${image ~/.conky/Spotify-Widget/spotify_icon.png -p 0,80 -s 80x80}\
	${goto 95}${voffset -8}${font Adele Medium:size=22}${exec bash ./Scripts/artist.sh}
	${goto 95}${voffset 3}${font Adele:size=22}${exec bash ./Scripts/title.sh}

