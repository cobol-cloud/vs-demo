﻿      *> Namespace: AmortWPFClient

      *> This class was auto-generated by the StronglyTypedResourceBuilder
      *> class via a tool like ResGen or Visual Studio.
      *> To add or remove a member, edit your .ResX file then rerun ResGen
      *> with the /str option, or rebuild your VS project.
      *>> <summary>
      *>>   A strongly-typed resource class, for looking up localized strings, etc.
      *>> </summary>
       class-id AmortWPFClient.Properties.Resources
           attribute System.CodeDom.Compiler.GeneratedCode("System.Resources.Tools.StronglyTypedResourceBuilder", "2.0.0.0")
           attribute System.Diagnostics.DebuggerNonUserCode()
           attribute System.Runtime.CompilerServices.CompilerGenerated()
           .

       working-storage section.
       01 resourceMan type System.Resources.ResourceManager static.
       01 resourceCulture type System.Globalization.CultureInfo static.

      *> Returns the cached ResourceManager instance used by this class.
       method-id get property ResourceManager static
           attribute System.ComponentModel.EditorBrowsable(type System.ComponentModel.EditorBrowsableState::Advanced) final.
       local-storage section.
       01 temp type System.Resources.ResourceManager.
       procedure division returning return-item as type System.Resources.ResourceManager.	   
       if object::ReferenceEquals(resourceMan null) then 
           set temp to new System.Resources.ResourceManager( "AmortWPFClient.Resources" type of AmortWPFClient.Properties.Resources::Assembly)
           set resourceMan to temp
       end-if
       set return-item to resourceMan
       goback
       end method.

      *> Overrides the current thread's CurrentUICulture property for all
      *> resource lookups using this strongly typed resource class.	  
       method-id get property Culture static
           attribute System.ComponentModel.EditorBrowsable(type System.ComponentModel.EditorBrowsableState::Advanced) final.
       procedure division returning return-item as type System.Globalization.CultureInfo.
       set return-item to resourceCulture
       goback
       end method.

       method-id set property Culture static final.
       procedure division using by value #value as type System.Globalization.CultureInfo.
       set resourceCulture to #value
       end method.
       
       method-id NEW protected
                    attribute System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode").
       procedure division.
       end method.

       end class.
