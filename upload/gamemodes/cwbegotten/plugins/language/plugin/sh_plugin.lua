PLUGIN:SetGlobalAlias("cwLanguage");

Clockwork.kernel:IncludePrefixed("cl_langmenu.lua");

cwLanguage.validLanguages = {
    ["runespeak"] = true,
    ["darkspeak"] = true,
    ["highglazic"]    = true,
    ["glazic"] = true
}

--
cwLanguage.langTable = {
    ["runespeak"] = "the Fathertongue",
    ["darkspeak"] = "Ur-Zohar",
    ["highglazic"]    = "Ecclesiastical Glazic",
    ["glazic"] = "the commoner's Glazic"
}

cwLanguage.langRefers = {
    ["runespeak"] = "the Fathertongue",
    ["darkspeak"] = "Ur-Zohar",
    ["highglazic"]    = "Ecclesiastical Glazic",
    ["glazic"] = "the commoner's Glazic"
}

local langMap = {
    ["runespeak"] = "Goreic Warrior",
    ["highglazic"] = "Holy Hierarchy",
    ["darkspeak"] = "Children of Satan"
};

cwLanguage.gore_dict = {
    ["hello"]  = "gruk",
	["gore"] = "gore",     
    ["food"]   = "morg",     
    ["fire"]   = "brakk",    
    ["blood"]  = "groma",     
    ["kill"]   = "krath",     
    ["flesh"]  = "slag",      
    ["bone"]   = "krukk",     
    ["war"]    = "grath",    
    ["death"]  = "morta",     
    ["demon"]  = "mordak",
	["slave"] = "fange",
	["grock"] = "grokth",
	["harald"] = "hrag",
	["shagalax"] = "shagralg",
	["crast"] = "krasth",
	["glaze"] = "glarz",
	["knight"] = "drom",
	["coin"] = "krag",
	["dark"] = "drakmorg",
	["banner"] = "gravorn"
};

cwLanguage.gore_syllables = {
	"gra", "kru", "mor", "ra", "vr", "gr", "eh", "ri", "rag", "ul", "kra", "zog"
};

cwLanguage.glaze_dict = {
    ["greetings"]   = "salvete",    
    ["glaze"]   = "deus",   
    ["praise"]  = "laus",      
    ["be"]     = "be",       
    ["yes"]      = "sic",    
    ["no"]  = "nul",
	["please"] = "placeo",
    ["thanks"]  = "gratias",    
    ["good"]    = "bonum",     
    ["bad"]     = "nocens",     
    ["knight"] = "equis",
	["noble"] = "decorus",
	["pope"] = "sacrorum",
	["scripture"] = "scriptura",
	["holy"] = "sanctus",
	["manifesto"] = "edictum",
	["satan"] = "diabolus",
	["heresy"] = "haeresis",
	["children"] = "liberi",
	["heathen"] = "gentilis",
	["barbarian"] = "barbarus",
	["all"] = "omnis",
	["world"] = "mundus",
	["tower"] = "turrim",
	["light"] = "lux"
};

cwLanguage.glaze_syllables = {
    "la", "ti", "ra", "co", "rum", "us", "ca", "ta", "fe", "mi", "li", "um", "ro", "que"
};

cwLanguage.dark_dict = {
    ["hello"]   = "shlama",
    ["world"]   = "alma",
    ["dark"]    = "hashokha",
    ["yes"]     = "hen",
    ["no"]      = "la",
    ["power"]   = "hayla",
    ["demon"]   = "shedha",
    ["blood"]   = "dma",
    ["night"]   = "lelya",
    ["fire"]    = "nura",
    ["death"]   = "mota",
    ["soul"]    = "naphsha"
};

cwLanguage.dark_syllables = {
    "sha", "la", "ma", "na", "ra", "ha", "ya", "mo", "ta", "be", "dha", "ho", "kha"
};


function cwLanguage:ProperLang(player)
    local faction = player:GetFaction()
    local lang = langMap[faction]


    if not lang then return end
   
    return lang;
end


local COMMAND = Clockwork.command:New("Language");
    COMMAND.tip = "Toggle the use of a language.";
    COMMAND.text = "<string Language>"
    COMMAND.arguments = 1;
    COMMAND.alias = {"lang"}


    -- Called when the command has been run.
    function COMMAND:OnRun(player, arguments)
        local chosenLanguage = string.lower(arguments[1] or "")
        local bypass = false;

        if chosenLanguage == "glazic" then
            Clockwork.player:Notify(player, "You are now speaking in the commoner's Glazic.");
            player.speakingLanguage = nil;
            return;
        end


        if player:HasBelief("anthropologist") or Clockwork.player:HasFlags(player, "l") then
            bypass = true;
        end


        if not cwLanguage.validLanguages[chosenLanguage] then
            Clockwork.player:Notify(player, "Invalid language!");
            return;
        end
       
        if ((cwLanguage:ProperLang(player) != chosenLanguage) and (bypass == false)) then
            Clockwork.player:Notify(player, "You don't know that language!");
            return;
        end
   
        player.speakingLanguage = chosenLanguage;

        Clockwork.player:Notify(player, "You are now speaking in "..cwLanguage.langRefers[chosenLanguage]..".");
    end;
COMMAND:Register();