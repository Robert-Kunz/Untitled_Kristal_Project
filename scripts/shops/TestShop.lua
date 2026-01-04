local TestShop, super = Class(Shop)

function TestShop:init()
    super.init(self)
    self.encounter_text               = "* H-hello! Welcome to my shop.\n[wait:5]* How can I help you?"
    self.shop_text                    = "* Did you need anything else?"
    self.leaving_text                 = "* Thanks for visiting!"
    self.buy_menu_text                = "Here's\nwhat I got.[emote:idle]"
    self.buy_confirmation_text        = "Want this\nfor %s?"
    self.buy_refuse_text              = "Come on..."
    self.buy_text                     = "* Glad you bought it!"
    self.buy_storage_text             = "Your inventory's full, so i put in your storage!"
    self.buy_too_expensive_text       = "come back\nwhen you're\na little... richer."
    self.buy_no_space_text            = "Your\npockets are\nfull, y'know..."
    self.sell_no_price_text           = "I-I'm sorry... I won't take this..."
    self.sell_menu_text               = "Oh, you want to sell something to me?!"
    self.sell_nothing_text            = "Nothin' there."
    self.sell_confirmation_text       = "I'll buy it \nfor %s.\nYou accept?"
    self.sell_refuse_text             = "aw come on?"
    -- Shown when you sell something
    self.sell_text                    = "Thanks! I've been looking for that"
    -- Shown when you have nothing in a storage
    self.sell_no_storage_text         = "Your storage is empty..."
    -- Shown when you enter the talk menu.
    self.talk_text                    = "Give it to me straight!"

    self.sell_options_text            = {}
    self.sell_options_text["items"]   = "Let's see what ya got."
    self.sell_options_text["weapons"] = "Let's see what ya got."
    self.sell_options_text["armors"]  = "Let's see what ya got."
    self.sell_options_text["storage"] = "Let's see what ya got."

    self.shopkeeper:setActor("shopkeepers/cube")
    self.shopkeeper.sprite:setPosition(-30, 50)
    self.shopkeeper.slide = true

    self:registerItem("Cake")
    self:registerItem("F_Jello")
    self:registerItem("Strength_Potion")
    self:registerItem("Bottle")

    self:registerTalk("About Yourself")
    self:registerTalk("About this place")
    self:registerTalk("Holy shit is that cube jsab")
    self:registerTalk("About Barracuda")

    self:registerTalkAfter("how you got here?", 1)
    self:registerTalkAfter("Relationships", 2, "talk_2", 1)
    self:registerTalkAfter("Your Universe", 2, "talk_2", 2)
    self:registerTalkAfter("He's back", 4)
end

--function Testshop:postInit()
--    super.postInit(self)
--    self.background_sprite:play(5/30, true)
--    self.shopkeeper:setLayer(SHOP_LAYERS["above_boxes"])
--end

function TestShop:startTalk(talk)
    if talk == "About Yourself" then
        self:startDialogue({ "[emote:Thought]* I don't know where to start...\n[wait:5]* Well uh... My name is Cube.",
            "[emote:talk]* Well, [wait:5]atleast I think that's my name. I'm not that sure.\n[wait:5]* I do from time to time get visitors so...[emote:sad]" })
    elseif talk == "how you got here?" then
        self:startDialogue({
            "[emote:concerned]* I, [wait:5]um, [wait:5]don't know...\n[wait:5]* Like i said, i just arrived here one day...",
            "[emote:talk]* Well, [wait:5]it's not that big of a problem, [wait:5]I think?[emote:idle]" })
    elseif talk == "Holy shit is that cube jsab" then
        self:startDialogue({ "[emote:talk]* I'm sorry?[emote:idle]" })
    elseif talk == "About this place" then
        self:setFlag("talk_2", 1)
        self:startDialogue({
            "[emote:talk]* Oh this place? [wait:5]I don't know...\n* I've just arrived here one day out of nowhere...[emote:sad]" })
    elseif talk == "Relationships" then
        self:setFlag("talk_2", 2)
        self:startDialogue({ "[emote:embarrassed]* O-oh, [wait:5]u-uh...\n[wait:5]* I don't want to talk about t-that." })
    elseif talk == "Your Universe" then
        self:startDialogue({ "[emote:Thought]* well...",
            "[emote:talk]* From what i remember, it was all just shapes and beats[emote:idle]" })
    elseif talk == "About Barracuda" then
        self:startDialogue({ "[emote:concerned]* W-what about him...?" })
    elseif talk == "He's back" then
        Game:setFlag("Talked_with_cube", true)
        self:startDialogue({ "[emote:concerned]* W-what?? I-I thought he was...",
            "* I-I thought [color:red]he[color:reset] made sure that...",
            "* N-no... [wait:10][emote:concerned]\n* Y-you MUST beat him[wait:5], before he makes any more havoc..." })
    end
end

return TestShop
