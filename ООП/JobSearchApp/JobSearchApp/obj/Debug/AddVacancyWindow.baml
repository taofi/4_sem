   M S B A M L   `   `   `  ����G  CJobSearchApp, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null+clr-namespace:JobSearchAppJobSearchApp  5   	   C&clr-namespace:JobSearchApp.userControlJobSearchApp.userControl  5   	   #    JobSearchApp.AddVacancyWindow   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   ,localclr-namespace:JobSearchApp     5   	   9custom&clr-namespace:JobSearchApp.userControl     5   	     � Title$  AddVacancyWindow��5	   	   $	��240��6"   $	��500��6/   .��5
      � $��10q�6    � RowDefinitions 5   
   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   .+�5   
   �� $��0��6   $��CompanyName:��6!   �� 5   
   -   5        $��CompanyName_textBox��5      $��0��6-   $��5q�6:   $	��180��6E   �� 5   
   $��1��6   $��Company Logo:��6!   �� 5   
   -   5        $	��120��5      $��1��6   $��choose��6+   $��5q�6T      ButtonStyle#���   6_   �� 5   
   $��2��6   $��
Job Title:��6!   �� 5   
   -   5        $��JobTitle_textBox��5      $��2��6*   $��5q�67   $	��180��6B   �� 5   
   $��3��6   $��Salary:��6!   �� 5   
   -   5        $��Salary_textBox��5      $��3��6(   $��5q�65   $	��180��6@   � 5    
   $��4��6    � ColumnDefinitions 5!      �� 5"      $��* �6#   �� 5#      $��* �6#   .+�5&      �� -   5        $��0��5&      $	��Add��6%   $��5q�6K   #���   6V   �� 5'      -   5        $��1��5'      $��Cancel��6%   $��5q�6Q   #���   6\   5(      5*      5+      