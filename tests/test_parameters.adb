------------------------------------------------------------------------------
--                                                                          --
--                      POSIX.5b VALIDATION TEST SUITE                      --
--                                                                          --
--                       T e s t _ P a r a m e t e r s                      --
--                                                                          --
--                                B o d y                                   --
--                                                                          --
--                                                                          --
--  Copyright (c) 1997-1998 Florida  State  University  (FSU).  All Rights  --
--  Reserved.                                                               --
--                                                                          --
--  This is free software;  you can redistribute it and/or modify it under  --
--  terms of the  GNU  General  Public  License  as published by the  Free  --
--  Software Foundation;  either version 2, or (at your option) any  later  --
--  version.  This  software  is distributed  in the hope that it  will be  --
--  useful, but WITHOUT ANY WARRANTY; without even the implied warranty of  --
--  MERCHANTABILITY   or  FITNESS FOR A PARTICULAR PURPOSE.   See the  GNU  --
--  General Public License for more details.  You  should have  received a  --
--  copy of the GNU General Public License  distributed  with  GNARL;  see  --
--  file  COPYING.  If not,  write to  the  Free  Software  Foundation, 59  --
--  Temple Place - Suite 330, Boston, MA 02111-1307, USA.                   --
--                                                                          --
--  Under contract  GS-35F-4506G, the U. S. Government obtained  unlimited  --
--  rights in the software and documentation contained herein.   Unlimited  --
--  rights are defined in DFAR 252,227-7013(a)(19).  By making this public  --
--  release,   the  Government  intends  to  confer  upon  all  recipients  --
--  unlimited  rights equal to those held by the Government.  These rights  --
--  include rights to use,  duplicate,  release  or  disclose the released  --
--  data an computer software  in whole or in part,  in any manner and for  --
--  any purpose whatsoever, and to have or permit others to do so.          --
--                                                                          --
--  DISCLAIMER   --   ALL MATERIALS OR INFORMATION HEREIN RELEASED,   MADE  --
--  AVAILABLE OR DISCLOSED ARE AS IS.   THE GOVERNMENT MAKES NO EXPRESS OR  --
--  IMPLIED WARRANTY AS TO ANY MATTER WHATSOEVER, INCLUDING THE CONDITIONS  --
--  OF THE SOFTWARE,  DOCUMENTATION  OR  OTHER INFORMATION RELEASED,  MADE  --
--  AVAILABLE OR DISCLOSED,  OR THE OWNERSHIP, MERCHANTABILITY, OR FITNESS  --
--  FOR A PARTICULAR PURPOSE OF SAID MATERIAL.                              --
--                                                                          --
------------------------------------------------------------------------------
--  [$Revision$]

with Ada.Text_IO,
     Ada.Characters.Handling,
     POSIX,
     POSIX_Signals;

package body Test_Parameters is

   use Ada.Text_IO,
       Ada.Characters.Handling,
       POSIX,
       POSIX_Signals;

   function Valid_MQ_Name
     (N : Positive) return POSIX_String is
      S : constant String := Integer'Image (N);
   begin
      return "/mq_" & To_POSIX_String (S (S'First + 1 .. S'Last));
   end Valid_MQ_Name;

   function Invalid_MQ_Name
     (N : Positive) return POSIX_String is
   begin
      if N = 1 then return "(#@!$%^~??||++";
      else return "~!@#$%^&*()_++_}{{.//";
      end if;
   end Invalid_MQ_Name;

   function Valid_Shared_Memory_Object_Name
     (N : Positive) return POSIX_String is
      S : constant String := Integer'Image (N);
   begin
      return "/shm_" & To_POSIX_String (S (S'First + 1 .. S'Last));
   end Valid_Shared_Memory_Object_Name;

   function Invalid_Shared_Memory_Object_Name
     (N : Positive) return POSIX_String is
   begin
      if N = 1 then return "(#@!$%^~??||++";
      else return "~!@#$%^&*()_++_}{{.//";
      end if;
   end Invalid_Shared_Memory_Object_Name;

   function Valid_Block_Device_Name return POSIX_String is
      File : File_Type;
      Buf : String (1 .. 128);
      Last : Integer;
   begin
      begin
         Open (File, In_File, "/etc/mnttab");
      exception
      when others =>
         begin
            Open (File, In_File, "/etc/mtab");
         exception
         when others =>
            return "could_not_find_block_device";
         end;
      end;
      --  Try searching /etc/mnttab or /etc/mtab for a device name.
      loop
         Get_Line (File, Buf, Last);
         if Last >= 4 and Buf (1 .. 4) = "/dev" then
            for I in 1 .. Last loop
               if (Is_Alphanumeric (Buf (I)) = False and
                   Is_Special (Buf (I)) = False) then
                  return To_POSIX_String (Buf (1 .. I - 1));
               end if;
            end loop;
         end if;
      end loop;
      return "could_not_find_block_device";
   end Valid_Block_Device_Name;

   function Valid_Character_Special_File_Name return POSIX_String is
   begin
      return "/dev/tty";
   end Valid_Character_Special_File_Name;

   function Valid_Nonexistent_File_Name return POSIX_String is
   begin
      return "Nonexistent_File";
   end Valid_Nonexistent_File_Name;

   function Is_Reserved_Signal
     (Sig : Signal) return Boolean is
   begin
      case Sig is
      --  The required reserved signals
      when SIGILL  | SIGABRT | SIGFPE  | SIGKILL | SIGBUS |
           SIGSEGV | SIGALRM | SIGSTOP
         => return True;
--        --  Additional reserved signals for GNAT with Leroy Linux threads
--        when SIGUSR1 | SIGUSR2 | SIGINT
--          |  5 --  SIGTRAP
--          | 26 --  SIGVTALRM
--          | 31 --  SIGUNUSED
--           => return True;
      when 32  --  SIGWAITING
        | 33   --  SIGLWP
        | 36   --  SIGCANCEL
        | 44   --  out of range for System.Interrupts.Interrupt_ID
        | 45   --  out of range for System.Interrupts.Interrupt_ID
         => return True;
      when others => return False;
      end case;
   end Is_Reserved_Signal;

   function Action_Cannot_Be_Set
     (Sig : Signal) return Boolean is
   begin
      case Sig is
      --  The required reserved signals, and SIGNULL
      when SIGILL  | SIGABRT | SIGFPE  | SIGKILL | SIGBUS |
           SIGSEGV | SIGALRM | SIGSTOP | SIGNULL
         => return True;
--        --  Additional reserved signals for GNAT with Leroy Linux threads
--        when SIGUSR1 | SIGUSR2 | SIGINT
--          |  5 --  SIGTRAP
--          | 26 --  SIGVTALRM
--          | 31 --  SIGUNUSED
--           => return True;
      --  Additional reserved signals for GNAT with Solaris 2.6
      when 32  --  SIGWAITING
        | 33   --  SIGLWP
        | 36   --  SIGCANCEL
        | 44   --  out of range for System.Interrupts.Interrupt_ID
        | 45   --  out of range for System.Interrupts.Interrupt_ID
         => return True;
      when others => return False;
      end case;
   end Action_Cannot_Be_Set;

   function Signal_Mask_Is_Process_Wide return Boolean is
   begin
      return True;
   end Signal_Mask_Is_Process_Wide;

   function Valid_Semaphore_Name
     (N : Positive) return POSIX_String is
      S : constant String := Integer'Image (N);
   begin
      return "/sem_" & To_POSIX_String (S (S'First + 1 .. S'Last));
   end Valid_Semaphore_Name;

   function Delay_Unit return Duration is
   begin
      --  For DOS & Linux on PC
      return 0.1;
   end Delay_Unit;

   function Short_Watchdog_Timeout return Duration is
   begin
      return 15.0;
   end Short_Watchdog_Timeout;

   function Unused_Group_Name return POSIX_String is
   begin
      return "not_a_group_name";
   end Unused_Group_Name;

end Test_Parameters;
