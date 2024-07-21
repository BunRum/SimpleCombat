local ease = {}
function ease.InConst(x: number): number
	return x < 1 and 0 or 1
end
function ease.OutConst(x: number): number
	return x < 1 and 0 or 1
end
function ease.InOutConst(x: number): number
	return x < 1 and 0 or 1
end

function ease.InLinear(x: number): number
	return x
end
function ease.OutLinear(x: number): number
	return x
end
function ease.InOutLinear(x: number): number
	return x
end

function ease.InQuad(x: number): number
	return x * x
end
function ease.OutQuad(x: number): number
	return 1 - (1 - x) * (1 - x)
end
function ease.InOutQuad(x: number): number
	return x < 0.5 and 2 * x * x or 1 - math.pow(-2 * x + 2, 2) / 2
end

function ease.InCubic(x: number): number
	return math.pow(x, 3)
end
function ease.OutCubic(x: number): number
	return 1 - math.pow(1 - x, 3)
end
function ease.InOutCubic(x: number): number
	return x < 0.5 and 4 * math.pow(x, 3) or 1 - math.pow(-2 * x + 2, 3) / 2
end

function ease.InQuart(x: number): number
	return math.pow(x, 4)
end
function ease.OutQuart(x: number): number
	return 1 - math.pow(1 - x, 4)
end
function ease.InOutQuart(x: number): number
	return x < 0.5 and 8 * math.pow(x, 4) or 1 - math.pow(-2 * x + 2, 4) / 2
end

function ease.InQuint(x: number): number
	return math.pow(x, 5)
end
function ease.OutQuint(x: number): number
	return 1 - math.pow(1 - x, 5)
end
function ease.InOutQuint(x: number): number
	return x < 0.5 and 16 * math.pow(x, 5) or 1 - math.pow(-2 * x + 2, 5) / 2
end

function ease.InHexic(x: number): number
	return math.pow(x, 6)
end
function ease.OutHexic(x: number): number
	return 1 - math.pow(1 - x, 6)
end
function ease.InOutHexic(x: number): number
	return x < 0.5 and 32 * math.pow(x, 6) or 1 - math.pow(-2 * x + 2, 6) / 2
end

function ease.InSeptic(x: number): number
	return math.pow(x, 7)
end
function ease.OutSeptic(x: number): number
	return 1 - math.pow(1 - x, 7)
end
function ease.InOutSeptic(x: number): number
	return x < 0.5 and 64 * math.pow(x, 7) or 1 - math.pow(-2 * x + 2, 7) / 2
end

function ease.InOctic(x: number): number
	return math.pow(x, 8)
end
function ease.OutOctic(x: number): number
	return 1 - math.pow(1 - x, 8)
end
function ease.InOutOctic(x: number): number
	return x < 0.5 and 128 * math.pow(x, 8) or 1 - math.pow(-2 * x + 2, 8) / 2
end

function ease.InCirc(x: number): number
	return 1 - math.sqrt(1 - math.pow(x, 2))
end
function ease.OutCirc(x: number): number
	return math.sqrt(1 - math.pow(x - 1, 2))
end
function ease.InOutCirc(x: number): number
	return x < 0.5
		and (1 - math.sqrt(1 - math.pow(2 * x, 2))) / 2
		or (math.sqrt(1 - math.pow(-2 * x + 2, 2)) + 1) / 2
end

function ease.InExpo(x: number): number
	return x == 0 and 0 or math.pow(2, 10 * x - 10)
end
function ease.OutExpo(x: number): number
	return x == 1 and 1 or 1 - math.pow(2, -10 * x)
end
function ease.InOutExpo(x: number): number
	return x == 0
		and 0
		or x == 1
		and 1
		or x < 0.5 and math.pow(2, 20 * x - 10) / 2
		or (2 - math.pow(2, -20 * x + 10)) / 2;
end

function ease.InSine(x: number): number
	return 1 - math.cos((x * math.pi) / 2)
end
function ease.OutSine(x: number): number
	return math.sin((x * math.pi) / 2)
end
function ease.InOutSine(x: number): number
	return -(math.cos(math.pi * x) - 1) / 2
end

function ease.InBack(x: number): number
	local c1 = 1.70158
	local c3 = c1 + 1

	return c3 * math.pow(x, 3) - c1 * math.pow(x, 2)
end
function ease.OutBack(x: number): number
	local c1 = 1.70158
	local c3 = c1 + 1

	return 1 + c3 * math.pow(x - 1, 3) + c1 * math.pow(x - 1, 2)
end
function ease.InOutBack(x: number): number
	local c1 = 1.70158;
	local c2 = c1 * 1.525;

	return x < 0.5
		and (math.pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) / 2
		or (math.pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2
end

function ease.InBounce(x: number): number
	return 1 - ease.OutBounce(1 - x)
end
function ease.OutBounce(x: number): number
	local n1 = 7.5625;
	local d1 = 2.75;

	if (x < 1 / d1) then
		return n1 * math.pow(x, 2)
	elseif (x < 2 / d1) then
		x -= 1.5 / d1
		return n1 * math.pow(x, 2) + 0.75
	elseif (x < 2.5 / d1) then
		x -= 2.25 / d1
		return n1 * math.pow(x, 2) + 0.9375
	else
		x -= 2.625 / d1
		return n1 * math.pow(x, 2) + 0.984375
	end
end
function ease.InOutBounce(x: number): number
	return
		x < 0.5
		and (1 - ease.OutBounce(1 - 2 * x)) / 2
		or (1 + ease.OutBounce(2 * x - 1)) / 2;
end

function ease.InElastic(x: number): number
	local c4 = (2 * math.pi) / 3

	return x == 0
		and 0
		or x == 1
		and 1
		or -math.pow(2, 10 * x - 10) * math.sin((x * 10 - 10.75) * c4)
end
function ease.OutElastic(x: number): number
	local c4 = (2 * math.pi) / 3;

	return x == 0
		and 0
		or x == 1
		and 1
		or math.pow(2, -10 * x) * math.sin((x * 10 - 0.75) * c4) + 1;
end
function ease.InOutElastic(x: number): number
	local c5 = (2 * math.pi) / 4.5

	return x == 0
		and 0
		or x == 1
		and 1
		or x < 0.5
		and -(math.pow(2, 20 * x - 10) * math.sin((20 * x - 11.125) * c5)) / 2
		or (math.pow(2, -20 * x + 10) * math.sin((20 * x - 11.125) * c5)) / 2 + 1
end
return ease