------------------------------------------------------------------------------
--                                                                          --
--            FLORIST (FSU Implementation of POSIX.5) COMPONENTS            --
--                                                                          --
--                                D E P S 5 C                               --
--                                                                          --
--                                  B o d y                                 --
--                                                                          --
--                                                                          --
--  Copyright (c)  1996, 1997, 1998     Florida  State  University  (FSU),  --
--  All Rights Reserved.                                                    --
--                                                                          --
--  This file is a component of FLORIST, an  implementation of an  Ada API  --
--  for the POSIX OS services, for use with  the  GNAT  Ada  compiler  and  --
--  the FSU Gnu Ada Runtime Library (GNARL).   The  interface  is intended  --
--  to be close to that specified in  IEEE STD  1003.5: 1990  and IEEE STD  --
--  1003.5b: 1996.                                                          --
--                                                                          --
--  FLORIST is free software;  you can  redistribute  it and/or  modify it  --
--  under terms of the  GNU  General  Public  License as  published by the  --
--  Free Software Foundation;  either version  2, or (at  your option) any  --
--  later version.  FLORIST is distributed  in  the hope  that  it will be  --
--  useful, but WITHOUT ANY WARRANTY;  without  even the implied  warranty  --
--  of MERCHANTABILITY or FITNESS FOR A PARTICULAR  PURPOSE.  See  the GNU  --
--  General Public License for more details.  You  should have  received a  --
--  copy of the GNU General Public License  distributed  with  GNARL;  see  --
--  file  COPYING.  If not,  write to  the  Free  Software  Foundation, 59  --
--  Temple Place - Suite 330, Boston, MA 02111-1307, USA.                   --
--                                                                          --
--  As a special exception, if other files instantiate generics from  this  --
--  unit, or you link this unit with other files to produce an  executable, --
--  this  unit does not by itself cause the  resulting  executable  to  be  --
--  covered  by the  GNU  General  Public License. This exception does not  --
--  however invalidate any other  reasons why the executable file might be  --
--  covered by the GNU Public License.                                      --
--                                                                          --
------------------------------------------------------------------------------
--  [$Revision$]

--  This procedure is to force compilation of all the POSIX.5c packages.

with POSIX.Sockets;
with POSIX.Sockets.Internet;
--  with POSIX.Sockets.Local;
--  Local interfaces are not currently working
--  with POSIX.Sockets.ISO;
--  ISO interfaces are not currently implemented
with POSIX.XTI;
with POSIX.XTI.Internet;
--  with POSIX.XTI.ISO;
--  ISO interfaces are not currently implemented
--  with POSIX.XTI.MOSI;
--  MOSI interfaces are not currently implemented
with POSIX.Event_Management;

procedure deps5c is
begin
   null;
end deps5c;
