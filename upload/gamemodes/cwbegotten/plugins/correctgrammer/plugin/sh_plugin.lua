--[[
	created by xyz and converted by bokser.
--]]

--Grammar

local PLUGIN = PLUGIN;

do

local replacementWords = {
	["i"] = "I",
	["i'll"] = "I'll",
	["itll"] = "it'll",
	["ive"] = "I've",
	["i've"] = "I've",
	["im"] = "I'm",
	["i'm"] = "I'm",
	["u"] = "you",
	["pls"] = "please",
	["ur"] = "your",
	["ure"] = "you're",
	["u're"] = "you're",
	["k"] = "okay",
	["wat"] = "what",
	["btw"] = "by the way",
	["ull"] = "you'll",
	["youll"] = "you'll",
	["r"] = "are",
	["y"] = "why",
	["tho"] = "though",
	["yea"] = "yeah",
	["ol"] = "ol'",
	["couldnt"] = "couldn't",
	["shouldnt"] = "shouldn't",
	["wouldnt"] = "wouldn't",
	["idk"] = "I don't know",
	["wtf"] = "what the fuck",
	["gtg"] = "gotta go",
	["brb"] = "be right back",
	["dont"] = "don't",
	["cant"] = "can't",
	["wont"] = "won't",
	["didnt"] = "didn't",
	["doesnt"] = "doesn't",
	["aint"] = "ain't",
	["arent"] = "aren't",
	["theyve"] = "they've",
	["theres"] = "there's",
	["whatre"] = "what're",
	["theyre"] = "they're",
	["youve"] = "you've",
	["youre"] = "you're",
	["whos"] = "who's",
	["whats"] = "what's",
	["whys"] = "why's",
	["weve"] = "we've",
	["hes"] = "he's",
	["shes"] = "she's",
	["wheres"] = "where's",
	["cmon"] = "c'mon",
	["lol"] = "ha",
	["yknow"] = "y'know",
	["lookin"] = "lookin'",
	["eatin"] = "eatin'",
	["duckin"] = "duckin'",
	["drinkin"] = "drinkin'",
	["doin"] = "doin'",
	["fuckin"] = "fuckin'",
	["fukin"] = "fuckin'",
	["fuk"] = "fuck",
	["motherfuckin"] = "motherfuckin'",
	["vv"] = "w",
	["VV"] = "W",
}

local endingChars = {
	["."] = true,
	["?"] = true,
	["!"] = true,
	["~"] = true,
	["`"] = true,
	[","] = true,
	["<"] = true,
	[">"] = true,
	["/"] = true,
	["\\"] = true,
	["["] = true,
	["]"] = true,
	["="] = true,
	["-"] = true,
	["_"] = true,
	["+"] = true,
	["|"] = true,
	["*"] = true,
	[")"] = true,
	["("] = true,
	["&"] = true,
	["%"] = true,
	["$"] = true,
	["#"] = true,
	["@"] = true,
	[";"] = true,
	[":"] = true,
	["\""] = true,
	["'"] = true,
}

local toRemove = {}
for k,v in pairs(replacementWords) do
	toRemove[k] = v
end
for k,v in pairs(toRemove) do
	replacementWords[" "..k.." "] = " "..v.." "
	--for char,_ in pairs(endingChars) do --This slows things down too much because it makes the table massive. It allows fixing of words next to the listed special characters.
	--	replacementWords[" "..k..char] = " "..v..char
	--end
	replacementWords[k] = nil
end

local sub,find,upper = string.sub,string.find,string.upper
function PLUGIN:CorrectGrammar(sentence,noCapitalizeStart)
	sentence = " "..sentence.." "
	
	for k,v in pairs(replacementWords) do
		local replaceStart,replaceEnd = true
		
		while replaceStart do
			replaceStart,replaceEnd = find(sentence,k,1,true)
			if replaceStart then
				sentence = sub(sentence,1,replaceStart-1)..v..sub(sentence,replaceEnd+1)
			end
		end
	end
	
	sentence = sentence:Trim()
	
	if sentence == "" then return "" end
	
	if !endingChars[sentence[#sentence]] then
		sentence = sentence..(sentence == sentence:upper() and "!" or ".")
	end
	
	if !noCapitalizeStart and sentence[1] != sentence[1]:upper() then
		sentence = upper(sentence[1])..sub(sentence,2)
	end
	
	return sentence
end

end

hook.Add( "PlayerSay", "grammerfix", function( ply, text )
	local func,args,cmd
	if text:sub(1,1) == "/" then
		return text
	else
		text = PLUGIN:CorrectGrammar(text)
	end
	
	return text
end )
