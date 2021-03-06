import Foundation

public struct AlgorithmStep {
	
	// MARK: Type
	
	/// The types of algorithm step that can be executed.
	public enum StepType {
		
		/// Do emphasise `mainIndex` and optionally `extraIndex` and `extraExtraIndex`.
		case highlight
        
		/// The strength that a highlight should be
		public enum HighlightIntensity {
			case small
			case large
		}
		
        /// Move `mainIndex` to the end of the queue (or subqueue) for the current offset value.
        /// - note: this only really needs to be used for mergeSort
		case moveToJoiningArea
		
		/// When the merge for a given offset has completed
		case mergeComplete
		
		/// Swap `mainIndex` with `extraIndex`.
		case swap
        
		/// `mainIndex` should be moved to a temporary holding location.
		case hold
        
		/// Value should be moved out of the holding area.
		/// - note: no parameters required
		case unhold
        
		/// When `mainIndex` should slide to the position of `extraIndex`
		case slide

	}
	
	// MARK: Properties
	
	/// The type of algorithm step that should be performed
	public let type:StepType
	
	/// If `type` is `.higlight`, this is the intensity that the highlight should be.
	public let highlightIntensity:StepType.HighlightIntensity?
	
	/// In the case of a recursive algoithm, we will often want to keep track of the different recurive 'groups' that are formed, so we know exactly what element the animation should be performed on.
	public let mainSectionID:Int?
	
	/// In the event that additional info about another section is required (e.g. joining two sections together), this is where this info should be stored.
	public let extraSectionID:Int?
	
	/// The main index that this operation should be performing on.
	public let mainIndex:Int?
	
	/// In the event that additional info about another index is required (e.g. swapping elements at two index locations), this is where this info should be stored.
	public let extraIndex:Int?
	
	/// In the `StepType.move` case, we will want 2 indicies for which `mainIndex` should move between. These are `extraIndex` and `extraExtraIndex`.
	public let extraExtraIndex:Int?
    
	
	// MARK: General purpose initalisers
	
	/// Initalise a given type for indices (sections not required)
	public init(type:StepType, mainIndex:Int?=nil, extraIndex:Int?=nil, extraExtraIndex:Int?=nil, highlightIntensity:AlgorithmStep.StepType.HighlightIntensity?=nil) {
		self.type = type
		self.mainIndex = mainIndex
		self.extraIndex = extraIndex
		self.extraExtraIndex = extraExtraIndex
		self.highlightIntensity = highlightIntensity
		self.mainSectionID = nil
		self.extraSectionID = nil
	}
		
	/// Initalise a given type for sections (indicies not required)
	public init(type:StepType, mainSectionID:Int, extraSectionID:Int?=nil, highlightIntensity:AlgorithmStep.StepType.HighlightIntensity?=nil) {
		self.type = type
		self.mainSectionID = mainSectionID
		self.extraSectionID = extraSectionID
		self.highlightIntensity = highlightIntensity
		self.mainIndex = nil
		self.extraIndex = nil
		self.extraExtraIndex = nil
	}
	
	// MARK: Specific Initalisers
	
	/// Highlight the given indices with the given intensity.
	public init(highlightIndex mainIndex:Int, and extraIndex:Int?=nil, and extraExtraIndex:Int?=nil, withIntensity intensity: AlgorithmStep.StepType.HighlightIntensity) {
		self.init(type: .highlight,
		          mainIndex: mainIndex,
		          extraIndex: extraIndex,
		          extraExtraIndex: extraExtraIndex,
		          highlightIntensity: intensity)
	}
	
	/// Highlight the given sections with the given intensity.
	public init(highlightSection mainSectionID:Int, and extraSectionID:Int?=nil, withIntensity intensity: AlgorithmStep.StepType.HighlightIntensity) {
		self.init(type: .highlight,
		          mainSectionID: mainSectionID,
		          extraSectionID: extraSectionID,
		          highlightIntensity: intensity)
	}


	
	public init(moveToJoiningArea mainIndex:Int, toJoiningAreaIndexPosition extraIndex:Int) {
		self.init(type: .moveToJoiningArea,
		          mainIndex: mainIndex,
		          extraIndex: extraIndex)
	}

	
	/// Swap an index with another
	public init(swap mainIndex:Int, with extraIndex:Int) {
		self.init(type: .swap,
		          mainIndex: mainIndex,
		          extraIndex: extraIndex)
	}
	
	/// Move this index into the holding area.
	public init(hold mainIndex:Int) {
		self.init(type: .hold,
		          mainIndex: mainIndex)
	}
	
	/// Match `mainIndex` to `extraIndex`
	public init(slide mainIndex:Int, to extraIndex:Int?) {
		self.init(type: .slide,
		          mainIndex: mainIndex,
		          extraIndex: extraIndex)
	}

}
