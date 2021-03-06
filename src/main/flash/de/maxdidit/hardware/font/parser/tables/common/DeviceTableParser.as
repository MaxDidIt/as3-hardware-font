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
 
package de.maxdidit.hardware.font.parser.tables.common 
{ 
	import de.maxdidit.hardware.font.data.tables.common.device.DeviceTableData; 
	import de.maxdidit.hardware.font.parser.DataTypeParser; 
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser; 
	import de.maxdidit.hardware.font.parser.tables.ITableParser; 
	import flash.utils.ByteArray; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class DeviceTableParser implements ISubTableParser 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _dataTypeParser:DataTypeParser; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function DeviceTableParser(dataTypeParser:DataTypeParser) 
		{ 
			this._dataTypeParser = dataTypeParser; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
		 
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */ 
		 
		public function parseTable(data:ByteArray, offset:uint):* 
		{ 
			data.position = offset; 
			 
			var result:DeviceTableData = new DeviceTableData(); 
			result.startSize = _dataTypeParser.parseUnsignedShort(data); 
			result.endSize = _dataTypeParser.parseUnsignedShort(data); 
			 
			result.deltaFormat = _dataTypeParser.parseUnsignedShort(data); 
			 
			var range:uint = result.endSize - result.startSize; 
			if (result.deltaFormat == 1) 
			{ 
				// deltaValues are actually stored in 2 bit signed integers, 
				// one uint16 actually stores 8 values 
				range = Math.ceil(Number(range) / 8); 
			} 
			else if (result.deltaFormat == 2) 
			{ 
				// deltaValues are actually stored in 4 bit signed integers, 
				// one uint16 actually stores 8 values 
				range = Math.ceil(Number(range) / 4); 
			} 
			else if (result.deltaFormat == 3) 
			{ 
				// deltaValues are actually stored in 8 bit signed integers, 
				// one uint16 actually stores 2 values 
				range = Math.ceil(Number(range) / 2); 
			} 
			 
			var deltaValues:Vector.<uint> = new Vector.<uint>(); 
			for (var i:uint = 0; i <= range; i++) 
			{ 
				var value:uint = _dataTypeParser.parseUnsignedShort(data); 
				parseDeltaValue(value, result.deltaFormat, deltaValues); 
			} 
			 
			return result; 
		} 
		 
		private function parseDeltaValue(value:uint, deltaFormat:uint, deltaValues:Vector.<uint>):void 
		{ 
			if (deltaFormat == 1) 
			{ 
				for (var i:uint = 0; i < 8; i++) 
				{ 
					var shift:uint = (7 - i) * 2; 
					var data:int = ((value >> shift) & 0x3) | 0xFFFFFFFC; 
					deltaValues.push(data); 
				} 
			} 
			else if (deltaFormat == 2) 
			{ 
				for (i = 0; i < 4; i++) 
				{ 
					shift = (3 - i) * 4; 
					data = ((value >> shift) & 0xF) | 0xFFFFFFF0; 
					deltaValues.push(data); 
				} 
			} 
			else if (deltaFormat == 3) 
			{ 
				for (i = 0; i < 2; i++) 
				{ 
					shift = (1 - i) * 8; 
					data = ((value >> shift) & 0xFF) | 0xFFFFFF00; 
					deltaValues.push(data); 
				} 
			} 
		} 
	 
	} 
} 
