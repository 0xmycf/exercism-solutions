"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""
function ispangram(input)
    mask = 0
    check = 0
    for l in "abcdefghijklmnopqrstuvwxyz"
        l = uppercase(l)
        check |= (1 << (codepoint(l) - codepoint('A')))
    end
    for l in input
        l = uppercase(l)
        mask |= (1 << (codepoint(l) - codepoint('A')))
    end
    if check == (mask & check)
        return true
    end
    return false
end

