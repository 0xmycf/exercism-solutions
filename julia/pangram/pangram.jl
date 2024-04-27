"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""
function ispangram(input)
    mask = 0
    check = 0
    for l in 'A':'Z'
        check |= (1 << (codepoint(l) - codepoint('A')))
    end
    for l in input
        l = uppercase(l)
        mask |= (1 << (codepoint(l) - codepoint('A')))
    end
    return check == (mask & check)
end

