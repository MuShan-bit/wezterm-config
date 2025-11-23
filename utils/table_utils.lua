local function merge_tables(dst, src)
    for k, v in pairs(src) do
        if type(v) == "table" and type(dst[k]) == "table" then
            merge_tables(dst[k], v)
        else
            dst[k] = v
        end
    end
end


return {
    merge_tables = merge_tables,
}