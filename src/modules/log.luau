

return function (...)
    -- for i = 1, 10, 1 do
    --     print(debug.info(i, "s"))
    -- end
    -- print(debug.info(3, "s"))
    -- print(debug.traceback())
    warn(debug.traceback(nil, 2), "logged", ...)
end