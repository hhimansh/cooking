using System;
using System.Collections.Generic;

namespace Cooking.Models
{
    public partial class Measure
    {
        public Measure()
        {
            Category = new HashSet<Category>();
        }

        public string MeasureCode { get; set; }
        public string Name { get; set; }
        public string CategoryCode { get; set; }
        public double RatioToBase { get; set; }

        public virtual ICollection<Category> Category { get; set; }
    }
}
