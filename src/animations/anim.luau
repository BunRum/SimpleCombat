return {
	length = 1,
	init = {
		["Part"] = {
			class = "Part",
			parent = nil,
		},
	},
	vfx = {
		["Part"] = {
			["Size"] = {
				{ease = "OutLinear", time = 0, value = Vector3.new(4, 1, 2)},
			},
			["BottomSurface"] = {
				{ease = "OutLinear", time = 0, value = Enum.SurfaceType.Smooth},
			},
			["CanCollide"] = {
				{ease = "OutLinear", time = 0, value = false},
			},
			["CanQuery"] = {
				{ease = "OutLinear", time = 0, value = false},
			},
			["CFrame"] = {
				{ease = "OutLinear", time = 0, value = CFrame.new(-5, -0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
				{ease = "OutLinear", time = 0.1667, value = CFrame.new(5, -0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
				{ease = "OutLinear", time = 0.3333, value = CFrame.new(-5, -0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
				{ease = "OutLinear", time = 0.5, value = CFrame.new(5, -0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
				{ease = "OutLinear", time = 0.6667, value = CFrame.new(-5, -0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
				{ease = "OutLinear", time = 0.8333, value = CFrame.new(5, -0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
				{ease = "OutLinear", time = 1, value = CFrame.new(-5, -0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
			},
			["CanTouch"] = {
				{ease = "OutLinear", time = 0, value = false},
			},
			["TopSurface"] = {
				{ease = "OutLinear", time = 0, value = Enum.SurfaceType.Smooth},
			},
		},
	},
	emit = {
	},
	sfx = {
	},
	events = {
		{
			time = 0,
			list = {
				{name = "a"},
			},
		},
	},
}