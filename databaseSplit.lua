--
-- Created by IntelliJ IDEA.
-- User: doron
-- Date: 20/06/17
-- Time: 19:53
-- To change this template use File | Settings | File Templates.
--

redis.replicate_commands()
redis.set_repl(redis.REPL_NONE)

local cursor = 0

local flag = true

local counter = 0

repeat
    flag = false
    local output = redis.call("HSCAN", KEYS[1], cursor, "COUNT", 1)
    cursor = output[1]

    local id = output[2][1]
    local seq = output[2][2]
    if seq == nil then
        do return true end
        end
    local subSeq = string.sub(seq, 1, ARGV[1])
    redis.call("HSET", subSeq, id, seq)
    counter = counter + 1

until cursor == 0

return