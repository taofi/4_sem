   M S B A M L   `   `   `  ����G  CJobSearchApp, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null+clr-namespace:JobSearchAppJobSearchApp  5   	   $    JobSearchApp.EditVacancyWindow   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   ,localclr-namespace:JobSearchApp     5   	     � Title$  EditVacancyWindow��5   	   $	��220��6#   $	��500��60   .��5	      � $��10q�6    � RowDefinitions 5
   
   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   .+�5   
   �� $��Company Name:��6   $��0��6)   �� 5   
   -   5         ��Name$ companyNameTextBox��5      $��0��6.   $��5q�6;   $	��200��6F   �� 5   
   $��Company Logo:��6   $��1��6)   �� 5   
   -   5        $	��120��5      $��1��6   $��choose��6+   $��180,5,180,0q�6T      ButtonStyle#���   6i   $��35��6�   $	��Top=�6�   �� 5   
   $��
Job Title:��6   $��2��6&   �� 5   
   -   5        $ jobTitleTextBox��5      $��2��6+   $��5q�68   $	��200��6C   �� 5    
   $��Salary:��6   $��3��6#   �� 5!   
   -   5        $ salaryTextBox��5!      $��3��6)   $��5q�66   $	��200��6A   � 5#   
   $��5��6    � ColumnDefinitions 5$      �� 5%      $��* �6#   �� 5&      $��* �6#   .+�5)      �� -   5        $��0��5)      $
��Save��6%   $��4��6M   $��5q�6Z   #���   6e   �� 5+      -   5        $��1��5+      $��Cancel��6%   $��5��6Q   $��5q�6^   #���   6i   5,      5-      5.      