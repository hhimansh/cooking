using System;
using System.Collections.Generic;

namespace Cooking.Models
{
    public partial class Category
    {
        public string CategoryCode { get; set; }
        public string Name { get; set; }
        public string MeasureCode { get; set; }

        public virtual Measure MeasureCodeNavigation { get; set; }
    }
}
