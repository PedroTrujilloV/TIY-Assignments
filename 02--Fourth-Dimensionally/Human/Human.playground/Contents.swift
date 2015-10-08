//: # 02 -- Human -- Pedro Trujillo
//: 1. *Create a Playground named Human.*
///OK
//: 2. *Make a class named BodyPart.*
class BodyPart
{
    let Name: String
    let id:Int
    
    init( Name: String, id:Int)
    {
        self.Name = Name
        self.id = id
    }
    
    func getName()->String
    {return Name}
    
    func getId()->Int
    {return id}
    
}
//: 3. *Create 20 classes that are subclasses of BodyPart.*
//: - **1. Class Brain**
class Brain: BodyPart
{
    
    var isSleeping:Bool
    var isThinking:Bool
    var emotionsDic:Dictionary<String, Double>
   
    init()
    {
        self.isSleeping = false
        self.isThinking = true
        self.emotionsDic = [String:Double]()
        super.init( Name: "Brain", id: 1)
    }
    
    func setThinkingState()
    {
        self.isThinking = !isThinking
    }
    
    func setSleeping()
    {
     self.isSleeping = !isSleeping
    }
    
    func setEmotion(emotion:String, value:Double)
    {
        self.emotionsDic[emotion]=value
    }
}
//: - **2. Class Heart**
class Heart: BodyPart
{
    
    var heartbeat:Double
    var ventriclesDic:Dictionary<String, Bool>
    var atriumsDic:Dictionary<String, Bool>
    
    init(heartbeat:Double)
    {
        self.heartbeat = heartbeat
        self.ventriclesDic = [String: Bool]()
        self.atriumsDic = [String: Bool]()
        super.init( Name: "Heart", id: 2)

    }
    
    func setVentricles(ventricle:String, status:Bool)
    {
        self.atriumsDic[ventricle]=status
    }
    
    func setHeartbeat(heartbeat:Double)
    {
        self.heartbeat = heartbeat
    }
    
    func setAtriums(atrium:String, status:Bool)
    {
        self.atriumsDic[atrium]=status
    }
}
//: - **3. Class Lungs**
class Lung: BodyPart
{
    
    var inhale:Bool
    var capacity:Double
    var positionLeft:Bool
    
    init(inhale:Bool, capacity:Double, positionLeft:Bool)
    {
        self.inhale = inhale
        self.capacity = capacity
        self.positionLeft = positionLeft
        super.init( Name: "Lung", id: 3)
        
    }
    
    func getPosition()->String
    {
        if self.positionLeft
        {return "Left"}
        else
        {return "right"}
    }
    
    func setInhale()
    {
        self.inhale = !self.inhale
    }
    
    func setCapacity(capacity:Double)
    {
        self.capacity = capacity
    }
}

//: - **4. Class Stomach**
class Stomach: BodyPart
{
    
    var empty:Bool
    var capacity:Double
    var digesting:Bool
    
    init(empty:Bool, capacity:Double, digesting:Bool)
    {
        self.empty = empty
        self.capacity = capacity
        self.digesting = digesting
        super.init( Name: "Stomach", id: 4)
        
    }
    
    func isEmpty()->Bool
    {
        return empty
    }
    
    func setDigesting()
    {
        self.digesting = !self.digesting
    }
    
    func setCapacity(capacity:Double)
    {
        self.capacity = capacity
    }
}


//: - **5. Class Kidney**
class Kidney: BodyPart
{
    
    var excretion:Double
    var filtration:Double
    var positionLeft:Bool
    
    init(excretion:Double, filtration:Double, positionLeft:Bool)
    {
        self.excretion = excretion
        self.filtration = filtration
        self.positionLeft = positionLeft
        super.init( Name: "Kidney", id: 5)
        
    }
    
    func getPosition()->String
    {
        if self.positionLeft
        {return "Left"}
        else
        {return "right"}
    }
    
    func getExcretion()->Double
    {
        return self.excretion
    }
    
    func setFiltration(filtration:Double)
    {
        self.filtration = filtration
    }
}


//: - **6. Class Muscle**
class Muscle: BodyPart
{
    
    var contract:Bool
    var strength:Double
    var tired:Bool
    
    init(contract:Bool, strength:Double, tired:Bool)
    {
        self.contract = contract
        self.strength = strength
        self.tired = tired
        super.init( Name: "Muscle", id: 6)
        
    }
    
    func isContract()->Bool
    {
        return contract
    }
    
    func isTired()->Bool
    {
        return self.tired
    }
    
    func setStrength(strength:Double)
    {
        self.strength = strength
    }
}

//: - **7. Class Bone**
class Bone: BodyPart
{
    
    var kindOf:String
    var length:Double
    var articulate:Bool
    
    init(kindOf:String, length:Double, articulate:Bool)
    {
        self.kindOf = kindOf
        self.length = length
        self.articulate = articulate
        super.init( Name: "Bone", id: 7)
        
    }
    
    func setKindOf(kindOf:String)
    {
        self.kindOf = kindOf
    }
    
    func isArticulate()->Bool
    {
        return self.articulate
    }
    
    func setLength(length:Double)
    {
        self.length = length
    }
}

//: - **8. Class Blood**
class Blood: BodyPart
{
    
    var RH:String
    var quantity:Double
    var presure:Double
    
    init(RH:String, quantity:Double, presure:Double)
    {
        self.RH = RH
        self.quantity = quantity
        self.presure = presure
        super.init( Name: "Blood", id: 8)
        
    }
    
    func getRH()->String
    {
        return self.RH
    }
    
    func getPresure()->Double
    {
        return self.presure
    }
    
    func setQuantity(quantity:Double)
    {
        self.quantity = quantity
    }
}

//: - **9. Class Skin**
class Skin: BodyPart
{
    
    var color:String
    var length:Double
    var hydrated:Bool
    
    init(color:String, length:Double, hydrated:Bool)
    {
        self.color = color
        self.length = length
        self.hydrated = hydrated
        super.init( Name: "Skin", id: 9)
        
    }
    
    func setColor(color:String)
    {
        self.color = color
    }
    
    func isHydrated()->Bool
    {
        return self.hydrated
    }
    
    func setLength(length:Double)
    {
        self.length = length
    }
}

//: - **10. Class ears**
class Ear: BodyPart
{
    
    var listening:Bool
    var hearingCapacity:Double
    var positionLeft:Bool
    
    init(listening:Bool, hearingCapacity:Double, positionLeft:Bool)
    {
        self.listening = listening
        self.hearingCapacity = hearingCapacity
        self.positionLeft = positionLeft
        super.init( Name: "Ear", id: 10)
        
    }
    
    func getPosition()->String
    {
        if self.positionLeft
        {return "Left"}
        else
        {return "right"}
    }
    
    func setListening()
    {
        self.listening = !self.listening
    }
    
    func sethearingCapacity(hearingCapacity:Double)
    {
        self.hearingCapacity = hearingCapacity
    }
}

//: - **11. Class eye**
class Eye: BodyPart
{
    
    var color:String
    var visualCapacity:Double
    var positionLeft:Bool
    
    init(color:String, visualCapacity:Double, positionLeft:Bool)
    {
        self.color = color
        self.visualCapacity = visualCapacity
        self.positionLeft = positionLeft
        super.init( Name: "Eye", id: 11)
        
    }
    
    func getPosition()->String
    {
        if self.positionLeft
        {return "Left"}
        else
        {return "right"}
    }
    
    func setColor(color:String)
    {
        self.color = color
    }
    
    func setvisualCapacity(visualCapacity:Double)
    {
        self.visualCapacity = visualCapacity
    }
}


//: - **12. Class Head**
class Head: BodyPart
{
    var brain:Brain
    var leftEye:Eye
    var rightEye:Eye
    
    
    init(eyeColor:String, visualCapacity:Double)
    {
        self.brain = Brain()
        self.leftEye = Eye(color: eyeColor, visualCapacity: visualCapacity, positionLeft: true)
        self.rightEye = Eye(color: eyeColor, visualCapacity: visualCapacity, positionLeft: false)
        
       
        super.init( Name: "Head", id: 12)
        
    }
    
    func printEyesPosition()
    {
        print("Position left eye: \(self.leftEye.getPosition())")
        print("Position right eye: \(self.rightEye.getPosition())")
    }
    
    func setColorEyes(col:String)
    {
        self.leftEye.setColor(col)
        self.rightEye.setColor(col)
    }
    
    func setEyeVisualCapacity(visualCapacity:Double)
    {
        self.leftEye.visualCapacity = visualCapacity
        self.leftEye.visualCapacity = visualCapacity
    }
}


//: - **13. Class Intestine**
class Intestine: BodyPart
{
    
    var full:Bool
    var capacity:Double
    var digesting:Bool
    
    init(full:Bool, capacity:Double, digesting:Bool)
    {
        self.full = full
        self.capacity = capacity
        self.digesting = digesting
        super.init( Name: "Intestine", id: 13)
    }
    
    func isFull()->Bool
    {
        return full
    }
    
    func setDigesting()
    {
        self.digesting = !self.digesting
    }
    
    func setCapacity(capacity:Double)
    {
        self.capacity = capacity
    }
}



//: - **14. Class DegistiveSystem**
class DigestiveSystem: BodyPart
{
   
    var stomach:Stomach
    var largeIntestine:Intestine
    var smallIntestine:Intestine
    
    init(Capacity:Double, digesting: Bool)
    {

        self.stomach = Stomach(empty: true, capacity: Capacity, digesting: digesting)
        largeIntestine = Intestine(full:true, capacity:Capacity*2, digesting:true)
        smallIntestine = Intestine(full:false, capacity:3.0, digesting:true)
        
        super.init( Name: "DegistiveSystem", id: 14)
        
    }
}



//: - **15. Class Torso**
class Torso: BodyPart
{
    var head:Head
    var heart:Heart
    var digestiveSystem:DigestiveSystem
    
    init(color:String, visualCapacity:Double, positionLeft:Bool, Capacity:Double)
    {
        
        self.head = Head(eyeColor:"Blue", visualCapacity:22.0)
        self.heart = Heart(heartbeat: 30)
        self.digestiveSystem = DigestiveSystem(Capacity: Capacity, digesting: true)
        
        super.init( Name: "Torso", id: 15)
        
    }
    
    func getBodyPartID()->(head:Int, heart:Int, stomach:Int, brain: Int)
    {
        return (head:self.head.getId(), heart:self.heart.getId(), stomach:self.digestiveSystem.stomach.getId(), brain: self.head.brain.getId())
    }
    
}




