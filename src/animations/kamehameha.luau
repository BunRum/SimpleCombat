return {
	length = 1,
	init = {
		["Specs"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
		["rINGS"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
		["lines2outerspec"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
		["flameround1"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
		["lines2outerspec1"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
		["sHIMMERouter"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
		["sHIMMERinner"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
		["Kamehamehaball"] = {
			class = "Part",
			parent = nil,
		},
		["rINGS1"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
		["beamlight?"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
		["Attachment"] = {
			class = "Attachment",
			parent = "Kamehamehaball",
		},
		["flameround"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
		["ringsinner"] = {
			class = "ParticleEmitter",
			parent = "Attachment",
		},
	},
	vfx = {
		["Specs"] = {
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["Drag"] = {
				{ease = "OutLinear", time = 0, value = 7},
			},
			["ZOffset"] = {
				{ease = "OutLinear", time = 0, value = 3},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.75, 0.8999999761581421)},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(10.289999961853027, 13.720000267028809)},
			},
			["Brightness"] = {
				{ease = "OutLinear", time = 0, value = 4},
			},
			["FlipbookLayout"] = {
				{ease = "OutLinear", time = 0, value = Enum.ParticleFlipbookLayout.Grid4x4},
			},
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.20000000298023224, 0.5144999623298645, 0.34299999475479126), NumberSequenceKeypoint.new(1, 0, 0)})},
			},
			["FlipbookMode"] = {
				{ease = "OutLinear", time = 0, value = Enum.ParticleFlipbookMode.OneShot},
			},
			["RotSpeed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(-360, 360)},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["Rate"] = {
				{ease = "OutLinear", time = 0, value = 27.5},
			},
			["Rotation"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(-360, 360)},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.8592684268951416, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})},
			},
			["LightEmission"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["SpreadAngle"] = {
				{ease = "OutLinear", time = 0, value = Vector2.new(-360, 360)},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://11197917329"},
			},
		},
		["rINGS"] = {
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["Rate"] = {
				{ease = "OutLinear", time = 0, value = 100},
			},
			["Rotation"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(-360, 360)},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.47828999161720276, 1, 0), NumberSequenceKeypoint.new(0.5262899994850159, 0.9223333597183228, 0), NumberSequenceKeypoint.new(0.8122899532318115, 0.6756666898727417, 0), NumberSequenceKeypoint.new(1, 0.9856666922569275, 0), NumberSequenceKeypoint.new(1, 0.9856666922569275, 0)})},
			},
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2960416078567505, 0), NumberSequenceKeypoint.new(1, 1.1763198375701904, 0)})},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.5, 0.5)},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0, 0)},
			},
			["LightInfluence"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["SpreadAngle"] = {
				{ease = "OutLinear", time = 0, value = Vector2.new(360, 360)},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://15976435822"},
			},
		},
		["lines2outerspec"] = {
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.165858194231987, 0.328286349773407), NumberSequenceKeypoint.new(0.550000011920929, 0.35617363452911377, 0), NumberSequenceKeypoint.new(1, 0.34299999475479126, 0)})},
			},
			["ShapeInOut"] = {
				{ease = "OutLinear", time = 0, value = Enum.ParticleEmitterShapeInOut.InAndOut},
			},
			["SpreadAngle"] = {
				{ease = "OutLinear", time = 0, value = Vector2.new(360, 360)},
			},
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["ZOffset"] = {
				{ease = "OutLinear", time = 0, value = 5},
			},
			["Orientation"] = {
				{ease = "OutLinear", time = 0, value = Enum.ParticleOrientation.VelocityParallel},
			},
			["Rotation"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(90, 90)},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9723333716392517, 0), NumberSequenceKeypoint.new(0.4502899646759033, 0.9823333621025085, 0), NumberSequenceKeypoint.new(0.6902899742126465, 0.05566670745611191, 0), NumberSequenceKeypoint.new(1, 0.9856666922569275, 0)})},
			},
			["ShapePartial"] = {
				{ease = "OutLinear", time = 0, value = 0},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.20000000298023224, 0.699999988079071)},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(4.115999698638916, 4.115999698638916)},
			},
			["Brightness"] = {
				{ease = "OutLinear", time = 0, value = 10},
			},
			["Rate"] = {
				{ease = "OutLinear", time = 0, value = 100},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://15976256983"},
			},
		},
		["flameround1"] = {
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.20000000298023224, 0.5144999623298645, 0.34299999475479126), NumberSequenceKeypoint.new(1, 1.72101891040802, 0)})},
			},
			["FlipbookMode"] = {
				{ease = "OutLinear", time = 0, value = Enum.ParticleFlipbookMode.OneShot},
			},
			["RotSpeed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(-360, 360)},
			},
			["Rotation"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(-360, 360)},
			},
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["Drag"] = {
				{ease = "OutLinear", time = 0, value = 7},
			},
			["Rate"] = {
				{ease = "OutLinear", time = 0, value = 100},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["LightInfluence"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.8042899966239929, 0.952333390712738, 0), NumberSequenceKeypoint.new(1, 1, 0)})},
			},
			["LightEmission"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.75, 0.8999999761581421)},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.034299999475479126, 0.034299999475479126)},
			},
			["Brightness"] = {
				{ease = "OutLinear", time = 0, value = 10},
			},
			["SpreadAngle"] = {
				{ease = "OutLinear", time = 0, value = Vector2.new(-360, 360)},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://15988248410"},
			},
		},
		["lines2outerspec1"] = {
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.165858194231987, 0.328286349773407), NumberSequenceKeypoint.new(0.550000011920929, 0.35617363452911377, 0), NumberSequenceKeypoint.new(1, 0.34299999475479126, 0)})},
			},
			["ShapeInOut"] = {
				{ease = "OutLinear", time = 0, value = Enum.ParticleEmitterShapeInOut.InAndOut},
			},
			["SpreadAngle"] = {
				{ease = "OutLinear", time = 0, value = Vector2.new(360, 360)},
			},
			["Orientation"] = {
				{ease = "OutLinear", time = 0, value = Enum.ParticleOrientation.VelocityParallel},
			},
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["ZOffset"] = {
				{ease = "OutLinear", time = 0, value = -5},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.20000000298023224, 5)},
			},
			["Rotation"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(90, 90)},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9723333716392517, 0), NumberSequenceKeypoint.new(0.4502899646759033, 0.9823333621025085, 0), NumberSequenceKeypoint.new(0.7265759706497192, 0.8526666164398193, 0), NumberSequenceKeypoint.new(1, 0.9856666922569275, 0)})},
			},
			["ShapePartial"] = {
				{ease = "OutLinear", time = 0, value = 0},
			},
			["Squash"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 5, 0), NumberSequenceKeypoint.new(1, 5, 0)})},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(4.115999698638916, 4.115999698638916)},
			},
			["Brightness"] = {
				{ease = "OutLinear", time = 0, value = 10},
			},
			["Rate"] = {
				{ease = "OutLinear", time = 0, value = 100},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://16072462608"},
			},
		},
		["sHIMMERinner"] = {
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["ZOffset"] = {
				{ease = "OutLinear", time = 0, value = -1},
			},
			["LightInfluence"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.8962900042533875, 0.02566670812666416, 0), NumberSequenceKeypoint.new(1, 1, 0)})},
			},
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.424848198890686, 0), NumberSequenceKeypoint.new(1, 2.4310462474823, 0)})},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.20000000298023224, 0.30000001192092896)},
			},
			["LightEmission"] = {
				{ease = "OutLinear", time = 0, value = 0.5},
			},
			["Brightness"] = {
				{ease = "OutLinear", time = 0, value = 0.665},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.034299999475479126, 0.034299999475479126)},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://15976604780"},
			},
		},
		["Kamehamehaball"] = {
			["CanQuery"] = {
				{ease = "OutLinear", time = 0, value = false},
			},
			["CanCollide"] = {
				{ease = "OutLinear", time = 0, value = false},
			},
			["Color"] = {
				{ease = "OutLinear", time = 0, value = Color3.fromRGB(110, 153, 202)},
			},
			["CFrame"] = {
				{ease = "OutLinear", time = 0, value = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
			},
			["CanTouch"] = {
				{ease = "OutLinear", time = 0, value = false},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["Size"] = {
				{ease = "OutLinear", time = 0, value = Vector3.new(14.953, 3.738, 7.477)},
			},
			["Shape"] = {
				{ease = "OutLinear", time = 0, value = Enum.PartType.Ball},
			},
			["BottomSurface"] = {
				{ease = "OutLinear", time = 0, value = Enum.SurfaceType.Smooth},
			},
			["Material"] = {
				{ease = "OutLinear", time = 0, value = Enum.Material.Neon},
			},
			["CastShadow"] = {
				{ease = "OutLinear", time = 0, value = false},
			},
			["TopSurface"] = {
				{ease = "OutLinear", time = 0, value = Enum.SurfaceType.Smooth},
			},
		},
		["sHIMMERouter"] = {
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 3.430000066757202, 0)})},
			},
			["LightInfluence"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["ZOffset"] = {
				{ease = "OutLinear", time = 0, value = -1},
			},
			["TimeScale"] = {
				{ease = "OutLinear", time = 0, value = 0.6},
			},
			["Rotation"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(360, 360)},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.5367372035980225, 1, 0), NumberSequenceKeypoint.new(0.6062899827957153, 0.8856667280197144, 0), NumberSequenceKeypoint.new(0.704289972782135, 0.909000039100647, 0), NumberSequenceKeypoint.new(0.9227895140647888, 0.9937499761581421, 0), NumberSequenceKeypoint.new(1, 1, 0)})},
			},
			["LightEmission"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.5, 0.6000000238418579)},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.034299999475479126, 0.034299999475479126)},
			},
			["Brightness"] = {
				{ease = "OutLinear", time = 0, value = 0.665},
			},
			["Rate"] = {
				{ease = "OutLinear", time = 0, value = 4},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://11198241185"},
			},
		},
		["beamlight?"] = {
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["ZOffset"] = {
				{ease = "OutLinear", time = 0, value = -3},
			},
			["TimeScale"] = {
				{ease = "OutLinear", time = 0, value = 0.1},
			},
			["LightInfluence"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.20000000298023224, 0.5)},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.34299999475479126, 0.34299999475479126)},
			},
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.31880447268486023, 0, 0), NumberSequenceKeypoint.new(0.33457598090171814, 2.2253291606903076, 0.22175098955631256), NumberSequenceKeypoint.new(0.8045759797096252, 1.1924195289611816, 0), NumberSequenceKeypoint.new(1, 0, 0)})},
			},
			["RotSpeed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(360, 360)},
			},
			["ShapeInOut"] = {
				{ease = "OutLinear", time = 0, value = Enum.ParticleEmitterShapeInOut.Inward},
			},
			["Rate"] = {
				{ease = "OutLinear", time = 0, value = 100},
			},
			["Rotation"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(-360, 360)},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.15457598865032196, 1, 0), NumberSequenceKeypoint.new(0.34457600116729736, 0.8793333172798157, 0), NumberSequenceKeypoint.new(0.5722900032997131, 0.8756666779518127, 0), NumberSequenceKeypoint.new(1, 1, 0)})},
			},
			["EmissionDirection"] = {
				{ease = "OutLinear", time = 0, value = Enum.NormalId.Bottom},
			},
			["LightEmission"] = {
				{ease = "OutLinear", time = 0, value = 0.5},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://16072431677"},
			},
			["SpreadAngle"] = {
				{ease = "OutLinear", time = 0, value = Vector2.new(360, 360)},
			},
		},
		["rINGS1"] = {
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["Rate"] = {
				{ease = "OutLinear", time = 0, value = 0},
			},
			["Rotation"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(-360, 360)},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.1262899786233902, 1, 0), NumberSequenceKeypoint.new(0.6142899990081787, 1, 0), NumberSequenceKeypoint.new(1, 0, 0), NumberSequenceKeypoint.new(1, 0, 0)})},
			},
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.1309447288513184, 0), NumberSequenceKeypoint.new(1, 0.200883686542511, 0)})},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.5, 0.5)},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0, 0)},
			},
			["LightInfluence"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["SpreadAngle"] = {
				{ease = "OutLinear", time = 0, value = Vector2.new(360, 360)},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://15976650019"},
			},
		},
		["flameround"] = {
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["Drag"] = {
				{ease = "OutLinear", time = 0, value = 7},
			},
			["LightInfluence"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.75, 0.8999999761581421)},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(4.802000045776367, 4.802000045776367)},
			},
			["Brightness"] = {
				{ease = "OutLinear", time = 0, value = 10},
			},
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.20000000298023224, 0.5144999623298645, 0.34299999475479126), NumberSequenceKeypoint.new(1, 0, 0)})},
			},
			["FlipbookMode"] = {
				{ease = "OutLinear", time = 0, value = Enum.ParticleFlipbookMode.OneShot},
			},
			["RotSpeed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(-360, 360)},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["Rate"] = {
				{ease = "OutLinear", time = 0, value = 100},
			},
			["Rotation"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(-360, 360)},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.909000039100647, 0), NumberSequenceKeypoint.new(0.8022899627685547, 0.8423333764076233, 0), NumberSequenceKeypoint.new(1, 1, 0)})},
			},
			["LightEmission"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["SpreadAngle"] = {
				{ease = "OutLinear", time = 0, value = Vector2.new(-360, 360)},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://15988217005"},
			},
			["VelocityInheritance"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
		},
		["ringsinner"] = {
			["Size"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.9579464793205261, 0), NumberSequenceKeypoint.new(1, 0.9378296136856079, 0)})},
			},
			["LightInfluence"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["Color"] = {
				{ease = "OutLinear", time = 0, value = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.682353, 1)), ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.682353, 1))})},
			},
			["LockedToPart"] = {
				{ease = "OutLinear", time = 0, value = true},
			},
			["ZOffset"] = {
				{ease = "OutLinear", time = 0, value = 1},
			},
			["Orientation"] = {
				{ease = "OutLinear", time = 0, value = Enum.ParticleOrientation.VelocityParallel},
			},
			["Rotation"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(-360, 360)},
			},
			["Transparency"] = {
				{ease = "OutLinear", time = 0, value = NumberSequence.new({NumberSequenceKeypoint.new(0, 1, 0), NumberSequenceKeypoint.new(0.3642899692058563, 1, 0), NumberSequenceKeypoint.new(0.754289984703064, 0, 0), NumberSequenceKeypoint.new(0.9402899742126465, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)})},
			},
			["LightEmission"] = {
				{ease = "OutLinear", time = 0, value = 0.6},
			},
			["Lifetime"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.25, 0.25)},
			},
			["Speed"] = {
				{ease = "OutLinear", time = 0, value = NumberRange.new(0.34299999475479126, 0.34299999475479126)},
			},
			["Texture"] = {
				{ease = "OutLinear", time = 0, value = "rbxassetid://15976469018"},
			},
			["Rate"] = {
				{ease = "OutLinear", time = 0, value = 100},
			},
			["SpreadAngle"] = {
				{ease = "OutLinear", time = 0, value = Vector2.new(150, 150)},
			},
		},
	},
	emit = {
	},
	sfx = {
	},
	events = {
	},
}