   M S B A M L   `   `   `  ����G  CJobSearchApp, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null=#clr-namespace:JobSearchApp.CommandsJobSearchApp.Commands  5   	   C&clr-namespace:JobSearchApp.userControlJobSearchApp.userControl  5   	   +clr-namespace:JobSearchAppJobSearchApp  5   	       JobSearchApp.MainWindow   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   5local#clr-namespace:JobSearchApp.Commands     5   	   9custom&clr-namespace:JobSearchApp.userControl     5   	   (wclr-namespace:JobSearchApp     5   	     � Title$  
MainWindow��5
   	   $	��800��6   $	��600��6)    � Icon$ photo/icon.ico��65    J� CommandBindings 5      )  #System.Windows.Input.CommandBinding  5   
   -   5           Command$3 -local:UserCommand.OpenAddVacancyWindowCommand��5      6n     5   
   -   5        $4 .local:UserCommand.OpenEditVacancyWindowCommand��5      6p     5   
   -   5        $, &local:UserCommand.DeleteVacancyCommand��5      6j     5   
   -   5        $% local:UserCommand.SearchCommand��5      6c     5   
   -   5        $0 *local:UserCommand.ApplySalaryFilterCommand��5      6s     5   
   -   5        $( "local:UserCommand.ApplySortCommand��5      6c   .��5      �    BackgroundColorWindow#���   6    � ColumnDefinitions 5   
   �� 5      $��* �6   �� 5      $	��250 �6   .+�5   
   �� -   5         ��Name$ listBox��5      $��0��6#   $��20q�6�   ��6_   �� *	Vacancies+��5      �� 5      .R�5      ��  �� Orientation$ 
Horizontal=�6!   .+�5      �� $��50��6?   $��50��6J   $��5q�6V   ��6    �� *CompanyLogo+6V   �� 5       .+�5!      �� $
��Bold"�6E   $��5q�6W   ��6(   �� *CompanyName+6W   �� 5"      $
��Bold"�6B   $��5q�6T   ��6(   �� *
JobTitle+6T   �� 5#      $��5q�6Z   ��6(   �� *Salary+ �� StringFormat$ ${0:N0}��6Z   �� 5$      $��5q�6i   ��6(   �� *	DateAdded+$ Added: {0:MM/dd/yyyy}��6i   5%      5&      5'      5)      �� 5+   
   $��1��6   $��10q�6%   .+�5,      ��   Add_btn#���  6   $3��-local:UserCommand.OpenAddVacancyWindowCommand��69   $	��230��6q   $��0,0,0,5q�6}     ButtonStyle#��[ 6�   �� 5-        Edit_btn#���  6   $4��.local:UserCommand.OpenEditVacancyWindowCommand��6:   $	��230��6t   $��0,0,0,5q�6�   #��[ 6�   �� 5.        
Delete_btn#���  6   $,��&local:UserCommand.DeleteVacancyCommand��6<   $	��230��6m   $��0,0,0,5q�6y   #��[ 6�   �� 52       
 Search#���  6   $
��Bold"�68   � 53      $��0,5,0,10q�6    54      �� 55      $	��160 �6'   65   �� 56      $��* �6'   63   .+�58      �� -   5         ��Name$ searchTextBox��58      $��0��61   $	��160��6A   $��35��6M   $
��Left=�6Y     BlueTextBoxStyle#��[ 6t   �� 59      -	   5        $��
Search_btn��59      $��1��6+   $��65��6;   $��35��6F   $��Right=�6R     
Search_btn#���  6n   $%��local:UserCommand.SearchCommand��6�   #��[ 6�   5:      �� 5=        FilterBySalary#���  6   $
��Bold"�6@   �� 5>      $ 
Horizontal=�6   $	��0,5q�62   .+�5?      �� $
��Min:��6   $��0,5,10,0q�6(   �� 5@      -
   5        $ minSalaryTextBox��5@      $��75��64   $��0,0,10,0q�6?   #��[ 6Q   �� 5A      $
��Max:��6   $��0,5,10,0q�6(   �� 5B      -   5        $ maxSalaryTextBox��5B      $��75��64   $��0,0,10,0q�6?   #��[ 6Q   5C      �� 5D       	 	Apply_btn#��� 	 6   $0��*local:UserCommand.ApplySalaryFilterCommand��6;   #��[ 6p   �� 5G      -   5        $��OrderBy��5G       
 OrderBy#��� 
 6'   $
��Bold"�6H   � 5J      $��0,5,0,10q�6    5K      �� 5L      $	��140 �6'   65   �� 5M      $��* �6'   63   .+�5O      �� -   5        	 ��Name$	 sortByComboBox��5O      $	��140��63   $��24��6?   
 �� SelectedIndex$
 3��6K   .@�5P      �� $��Alphabetical Order��6#   �� 5Q      $��Price: Low to High��6#   �� 5R      $��Price: High to Low��6#   �� 5S      $��Date Added: Newest First��6#   �� 5T      $��Date Added: Oldest First��6#   5U      �� 5V      #��� 	 6   $��85��6?   $��Right=�6J   $��1��6f   $(��"local:UserCommand.ApplySortCommand��6v   #��[ 6�   5W      �� 5Y      $ 
Horizontal=�6   .+�5Z      �� -   5        $��Center=�5Z      .+�5[      �� -   5        $��80��5[      $��50��6(   $��2q�6Y   .��5\      A� -   5        $��30��5\   "   $��30��6-   
���  ��6D   5]      5^      �� 5_      -   5        $��Center=�5_      .+�5`      � -   5        $��50��5`      $��50��6&   
���   �$��Center=�6E   .+�5a      A� -   5        $��30��5a   "   $��30��6-   
���  ��6D   5b      5c      5d      �� 5e      -   5         ��Name$ 
textBlock1��5e      $��1��6,    �� Padding$ 10q�6<   5g      5h      5i      