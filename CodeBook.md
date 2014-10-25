This document describes the dataset contained in tidy.mean.subset.txt


Variable:           Subject

    Description:    An identifier of the subject that carried out the experiement.
    Units:          An identifer.  No specific units.
    Processing:     None.  
    
    
Variable:           Activity

    Description:    Describes the activity being performed by the subject.  Possible
                    values are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
                    STANDING, and LAYING.
    Units:          None.
    
Variable:           Feature

    Description:    The the feature for with the mean is being calculated.  There are several hundred
                    features in the dataset.  Refer to smartphone/features_info.txt for details
    Units:          This is a text lable.
    
Variable: Mean

    Description:    The is a mean of all of the instances of Feature for each unique Subject and 
                    Activity pair.
                    
    Units:          See the units of the Feature as described in smartphone/features_info.txt 
    
    
    
    