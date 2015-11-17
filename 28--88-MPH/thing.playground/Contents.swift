//: Playground - noun: a place where people can play

import UIKit

NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
    ^(double p) { return (p + 2); }, @"addTwo",
    ^(double p) { return (p * 3); }, @"mulThree",
    ^(double p) { return sqrt(p); }, @"root",
    nil];

double x = 2.5;
for (id key in dict) {
    double (^func)(double) = [dict objectForKey:key];
    NSLog(@"%@: %f", key, func(x));
}