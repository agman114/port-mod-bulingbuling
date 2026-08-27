
description = "不灵小姐似乎在绝赞遇难中"
author = "贝尔LRB4"
version = "1.42"
name = "[Bulingbuling] v"..version
forumthread=""

api_version = 10
priority = -2
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true
all_clients_require_mod = true
client_only_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
"character",
"bulingbuling",
}

configuration_options = {
{name = "languages",
		label = "Languages/语言",
		options = {
			{description = "中文",    data = 1 },
			{description = "English",   data = 2 },
		},
		default = 1 
}
}
