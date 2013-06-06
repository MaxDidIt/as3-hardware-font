package de.maxdidit.hardware.font.data.tables.truetype.glyf
{
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.list.LinkedList;
	import de.maxdidit.math.AxisAlignedBoundingBox;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Glyph
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _header:GlyphHeader;
		
		private var _glyphClass:uint;
		
		private var _advanceWidth:uint;
		private var _leftSideBearing:int;
		
		//private var _substitutionLookups:Vector.<IGlyphLookup>;
		//private var _positioningLookups:Vector.<IGlyphLookup>;
		
		private var _index:uint;
		private var _lookupMap:Vector.<Vector.<Vector.<IGlyphLookup>>>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Glyph()
		{
			_lookupMap = new Vector.<Vector.<Vector.<IGlyphLookup>>>();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// header
		
		public function get header():GlyphHeader
		{
			return _header;
		}
		
		public function set header(value:GlyphHeader):void
		{
			_header = value;
		}
		
		public function get advanceWidth():uint
		{
			return _advanceWidth;
		}
		
		public function set advanceWidth(value:uint):void
		{
			_advanceWidth = value;
		}
		
		public function get leftSideBearing():int
		{
			return _leftSideBearing;
		}
		
		public function set leftSideBearing(value:int):void
		{
			_leftSideBearing = value;
		}
		
		public function get glyphClass():uint
		{
			return _glyphClass;
		}
		
		public function set glyphClass(value:uint):void
		{
			_glyphClass = value;
		}
		
		//public function get substitutionLookups():Vector.<IGlyphLookup> 
		//{
		//return _substitutionLookups;
		//}
		//
		//public function set substitutionLookups(value:Vector.<IGlyphLookup>):void 
		//{
		//_substitutionLookups = value;
		//}
		//
		//public function get positioningLookups():Vector.<IGlyphLookup> 
		//{
		//return _positioningLookups;
		//}
		//
		//public function set positioningLookups(value:Vector.<IGlyphLookup>):void 
		//{
		//_positioningLookups = value;
		//}
		
		public function get index():uint
		{
			return _index;
		}
		
		public function set index(value:uint):void
		{
			_index = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function resolveDependencies(glyphTableData:GlyphTableData):void
		{
			// This glyph doesn't have any dependencies, everything is awesome;
		}
		
		public function retrievePaths(subdivisions:uint):Vector.<Vector.<Vertex>>
		{
			throw new Error("Can't execute retrieveShape for Glyph. Extend the Glyph class and implement this function.");
		}
		
		public function retrieveGlyphInstances(instances:Vector.<HardwareGlyphInstance>):void
		{
			// do nothing
		}
		
		public function getTagIndex(tag:String):int
		{
			switch(tag)
			{
				case TableNames.GLYPH_SUBSTITUTION_DATA:
					return 0;
					
				case TableNames.GLYPH_POSITIONING_DATA:
					return 1;
			}
			
			return -1;
		}
		
		public function addGlyphLookup(tag:String, lookupIndex:uint, glyphLookup:IGlyphLookup):void
		{
			var tagIndex:uint = getTagIndex(tag);
			if (tagIndex == -1)
			{
				return;
			}
			
			if (_lookupMap.length <= tagIndex)
			{
				_lookupMap.length = tagIndex + 1;
			}
			
			var lookupTables:Vector.<Vector.<IGlyphLookup>> = _lookupMap[tagIndex];
			if (!lookupTables)
			{
				lookupTables = new Vector.<Vector.<IGlyphLookup>>();
				_lookupMap[tagIndex] = lookupTables;
			}
			
			var lookups:Vector.<IGlyphLookup>
			if (lookupTables.length <= lookupIndex)
			{
				lookupTables.length = lookupIndex + 1;
				lookups = new Vector.<IGlyphLookup>();
				lookupTables[lookupIndex] = lookups;
			}
			else
			{
				lookups = lookupTables[lookupIndex];
			}
			
			lookups.push(glyphLookup);
		}
		
		public function applyGlyphLookup(tag:String, characterInstances:LinkedList, lookupTableIndex:uint):void
		{
			var tagIndex:uint = getTagIndex(tag);
			if (tagIndex == -1)
			{
				return;
			}
			
			if (tagIndex >= _lookupMap.length)
			{
				return;
			}
			
			var lookupTables:Vector.<Vector.<IGlyphLookup>> = _lookupMap[tagIndex];
			if (!lookupTables)
			{
				return;
			}
			
			if (lookupTableIndex >= lookupTables.length)
			{
				return;
			}
			
			var lookupTable:Vector.<IGlyphLookup> = lookupTables[lookupTableIndex];
			if (!lookupTable)
			{
				return;
			}
			
			var lt:uint = lookupTable.length;
			for (var i:uint = 0; i < lt; i++)
			{
				lookupTable[i].performLookup(characterInstances);
			}
		
		}
	
	}

}