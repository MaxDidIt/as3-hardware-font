/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright �2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
package de.maxdidit.hardware.font.data.tables.advanced.gpos.shared  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ValueFormat  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _xPlacement:Boolean; 
		private var _yPlacement:Boolean; 
		 
		private var _xAdvance:Boolean; 
		private var _yAdvance:Boolean; 
		 
		private var _xPlacementDevice:Boolean; 
		private var _yPlacementDevice:Boolean; 
		 
		private var _xAdvanceDevice:Boolean; 
		private var _yAdvanceDevice:Boolean; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ValueFormat()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member  
		/////////////////////// 
		 
		public function get xPlacement():Boolean  
		{ 
			return _xPlacement; 
		} 
		 
		public function set xPlacement(value:Boolean):void  
		{ 
			_xPlacement = value; 
		} 
		 
		public function get yPlacement():Boolean  
		{ 
			return _yPlacement; 
		} 
		 
		public function set yPlacement(value:Boolean):void  
		{ 
			_yPlacement = value; 
		} 
		 
		public function get xAdvance():Boolean  
		{ 
			return _xAdvance; 
		} 
		 
		public function set xAdvance(value:Boolean):void  
		{ 
			_xAdvance = value; 
		} 
		 
		public function get yAdvance():Boolean  
		{ 
			return _yAdvance; 
		} 
		 
		public function set yAdvance(value:Boolean):void  
		{ 
			_yAdvance = value; 
		} 
		 
		public function get xPlacementDevice():Boolean  
		{ 
			return _xPlacementDevice; 
		} 
		 
		public function set xPlacementDevice(value:Boolean):void  
		{ 
			_xPlacementDevice = value; 
		} 
		 
		public function get yPlacementDevice():Boolean  
		{ 
			return _yPlacementDevice; 
		} 
		 
		public function set yPlacementDevice(value:Boolean):void  
		{ 
			_yPlacementDevice = value; 
		} 
		 
		public function get xAdvanceDevice():Boolean  
		{ 
			return _xAdvanceDevice; 
		} 
		 
		public function set xAdvanceDevice(value:Boolean):void  
		{ 
			_xAdvanceDevice = value; 
		} 
		 
		public function get yAdvanceDevice():Boolean  
		{ 
			return _yAdvanceDevice; 
		} 
		 
		public function set yAdvanceDevice(value:Boolean):void  
		{ 
			_yAdvanceDevice = value; 
		} 
		 
	} 
} 
